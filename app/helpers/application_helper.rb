module ApplicationHelper
  
  def num_digits(num) # gets the length of a fixnum, #need this to get the length of the line cost to readjust the height
	  Math.log10(num).to_i + 1
  end
  
  
  def get_total(inv)
    if inv.total.nil? #checks if the inv has a custom total or not, if not it adds all the prices of the lines
      total = 0
      inv.lines.each do |x|
        total += x.price unless x.price.nil?
      end
      return '%.2f' % total #this nonsense rounds it to 2 decimal places
    else
      return '%.2f' % inv.total
    end
  end
end
