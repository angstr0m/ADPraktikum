require './AbstractSorter'

#test

class MergeSort < AbstractSorter
  def performSort()
    sortBetween(0,@data.size)
  end

  def sortBetween(index1, index2)
    @data = split(@data.slice(index1, index2))
  end
  
  def split(datalist)
    if (datalist.size <= 1)
      return datalist
    end
    
    index_half = (datalist.size/2).floor - 1
    
#    puts "Size: " + datalist.size.to_s
#    puts "Size/2: " + (datalist.size/2).floor.to_s
#    puts "HalberIndex " + index_half.to_s
      
    block1 = datalist.slice(0..index_half)
    #puts "Block1 " + block1.to_s
    block2 = datalist.slice((index_half + 1)..(datalist.size))
    #puts "Block2 " + block2.to_s
    
    list1 = split(block1)
    list2 = split(block2)
    
    return merge(list1, list2)
  end
  
  def merge(list_left, list_right)
    resultList = []
    
    while(list_left.size > 0 && list_right.size > 0)
      # falls (erstes Element der linkeListe <= erstes Element der rechteListe)
      if (compare(list_left[0], list_right[0]) < 1)
        # dann füge erstes Element linkeListe in die neueListe hinten ein und entferne es aus linkeListe
        resultList << list_left[0]
        list_left.delete_at(0)
      else       
        # sonst füge erstes Element rechteListe in die neueListe hinten ein und entferne es aus rechteListe
        resultList << list_right[0]
        list_right.delete_at(0)
      end
    end
    
    #    solange (linkeListe nicht leer)
    while (list_left.size > 0)
      # füge erstes Element linkeListe in die neueListe hinten ein und entferne es aus linkeListe
      resultList << list_left[0]
      list_left.delete_at(0)
    end
    
    # solange (rechteListe nicht leer)
    while (list_right.size > 0)
      # füge erstes Element rechteListe in die neueListe hinten ein und entferne es aus rechteListe
      resultList << list_right[0]
      list_right.delete_at(0)
    end
    
    return resultList
    
  end
end

#testMergeSort = MergeSort.new
##testMergeSort.fillDescending(10)
##testMergeSort.permuteRandom(50)
#testMergeSort.fillWithText('./MobyDick.txt')
#puts "SelectionSort"
#puts "-------------"
##puts "Unsorted Data"
##puts testMergeSort.data
#puts "-------------"
#testMergeSort.sort()