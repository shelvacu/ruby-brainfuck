arr=[]
30_000.times do
  arr << "\x00"
end
pointer = 0
file_name = $*.first
raw_bf = File.read(file_name)
#raw_bf.gsub(/[^<>\[\]+-,.]/,'')
char_int = 0
while char_int < raw_bf.length
  char = raw_bf[char_int]
  char_int += 1
  case char
  when "<"
      pointer -= 1
  when ">"
      pointer += 1
  when "["
      if arr[pointer] == "\x00"
        while raw_bf[char_int] != "]"
          char_int+=1
        end
      end
  when "]"
      if arr[pointer] != "\x00"
        char_int -= 2
        while raw_bf[char_int] != "["
          char_int -= 1
        end
        char_int += 1
      end
  when "+"
      arr[pointer] = ((arr[pointer].ord+1)%256).chr
  when "-"
      arr[pointer] = ((arr[pointer].ord-1)%256).chr
  when ","
      char =  stdin.read(1)
    if char == "\r"
      stdin.read(1)
      char = "\n"
    end
    arr[pointer] = char
    arr[pointer] = "\x00" if char.nil? #set to x00 if EOF reached
  when "."

      if arr[pointer] == "\n"
        puts
      else
        print arr[pointer]
      end
  end
end
