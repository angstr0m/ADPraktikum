require './AbstractSorter.rb'

class InsertionSort < AbstractSorter
  def performSort()
    sortBetween(0,@data.size - 1)
  end

  def sortBetween(index1, index2)
    for i in index1..index2 do
      einzusortierender_wert = self[i]
      j = i
      while j > 0 and compare(self[j-1], einzusortierender_wert) == 1 do
        self[j] = self[j - 1]
        j = j - 1
      end
      self[j] = einzusortierender_wert
    end
  end
end