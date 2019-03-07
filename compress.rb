class Compress
  @@options = {
      :step => 3
  }
  @@tmp = {
      :first_index => -1,
      :temp => Array.new,
      :seq => Array.new
  }

  def run(a)
    for i in 0..a.length()-1
      if @@tmp[:first_index] == -1
        @@tmp[:first_index] = i;
      else
        if a[i] - a[i-1] != 1
          if i - @@tmp[:first_index] == 1
            @@tmp[:temp].push(@@tmp[:seq][0])
          elsif i-@@tmp[:first_index]<@@options[:step]
            @@tmp[:temp].push(*@@tmp[:seq])
          else
            if @@tmp[:seq].length == 1
              @@tmp[:temp].push(a[@@tmp[:first_index]])
            elsif @@tmp[:seq].length >= @@options[:step]
              @@tmp[:temp].push(a[@@tmp[:first_index]].to_s + '-'+@@tmp[:seq][-1].to_s)
            else
              @@tmp[:temp].push(*@@tmp[:seq])
            end
          end
          @@tmp[:first_index] = i
          @@tmp[:seq] = []
        end
      end
      @@tmp[:seq].push(a[i])
      if i == a.length - 1
        if @@tmp[:seq].length == 1
          @@tmp[:temp].push(a[@@tmp[:first_index]])
        elsif @@tmp[:seq].length >= @@options[:step]
          @@tmp[:temp].push(a[@@tmp[:first_index]].to_s + '-'+@@tmp[:seq][-1].to_s)
        else
          @@tmp[:temp].push(@@tmp[:seq])
        end
        return @@tmp[:temp].join(",")
      end
    end
  end
end

obj = Compress.new
puts obj.run([1,2,3,4,5,6,7,8,10,12,13,14])
