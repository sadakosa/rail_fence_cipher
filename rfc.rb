$message = ARGV[1].split('')
$arr = []
$num = 3




# ======================================================
#                     ENCRYPT
# ======================================================

def create_arrs
    $num.times do 
        $arr.push([])
    end 
end

def add_col
    $arr.length.times do
        |x|
        $arr[x].push([])
    end
end

def change_row(dir, row)
    if dir == 'up'
        row -= 1
        row
    elsif dir == 'down'
        row += 1
        row
    end
end

def encrypt
    create_arrs
    row = 0
    col = 0
    dir = 'down'

    $message.map do
        |x| 

        if(col != 0)
            add_col
        end

        if (row == $num - 1)
            dir = 'up'
        elsif (row == 0)
            dir = 'down'
        end

        $arr[row][col] = x
        row = change_row(dir, row)
        col += 1
    end

    puts $arr.join('')
end

# ======================================================
#                     DECRYPT
# ======================================================

def figure_out_row_num(num)
    create_arrs
    tracker = {}
    row = 0
    col = 0
    dir = 'down'

    num.times do
        |x| 

        if(col != 0)
            add_col
        end

        if (row == $num - 1)
            dir = 'up'
        elsif (row == 0)
            dir = 'down'
        end

        if (tracker[row] == nil)
            tracker[row] = 1
        else 
            tracker[row] += 1
        end
        row = change_row(dir, row)
        col += 1
    end

    tracker
end



def decrypt
    row_hash = {}
    string = []

    num_letters = $message.length
    row_num = figure_out_row_num(num_letters)

    start = 0
    $num.times do 
        |x|
        row_hash[x] = $message[start, row_num[x]]
        start = start + row_num[x]
    end
    
    
    row = 0
    col = []
    $num.times do 
        col.push(0)
    end
    dir = 'down'
    num_letters.times do
        |x|

        string.push(row_hash[row][col[row]])

        # CHANGE COL
        col[row] +=1 

        # CHANGE ROW
        if (row == $num - 1)
            dir = 'up'
        elsif (row == 0)
            dir = 'down'
        end
        row = change_row(dir, row)
    end

    puts string.join('')
end




function = ARGV[0]
if(function == 'encrypt')
    encrypt
elsif(function == 'decrypt')
    decrypt
else
    puts 'please choose either encrypt or decrypt' 
end

