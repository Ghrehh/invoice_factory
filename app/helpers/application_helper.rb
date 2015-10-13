module ApplicationHelper
  
  def num_digits(num) # gets the length of a fixnum, #need this to get the length of the line cost to readjust the height
	  Math.log10(num).to_i + 1
  end
  
end
