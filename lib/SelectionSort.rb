require './AbstractSorter.rb'

class SelectionSort < AbstractSorter
  
  def performSort()
    sortBetween(0,@data.size - 1)
  end

  def sortBetween(index1, index2)
    n = index2
    links = index1

    while links < n
      #puts "durchlauf"
      min = links

      for i in (links + 1)..n
        if (compare(self[i], self[min]) == -1)
          min = i
        end
      end

      exchange(min, links)
      links += 1
    end
  end
end