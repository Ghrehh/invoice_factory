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
  
  def make_invoice(lines, total, block=nil)
    
    ##########################################
    ####### TOP RIGHT NONSENSE ###############
    ##########################################
    
    catx1 = 180 # coords for the top right stuff
    catx2 = 370
    
    leftwidth = 185
    rightwidth = 160
    
    size = 9
    
    bounding_box([catx1, 720], :width => leftwidth) do
    	text "ADDRESS REALLY LONG ONE:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, 720], :width => rightwidth) do
    	text "Test this is please workTest this is please. It's longer. This is longer now :D SOMETHING :DD :DD", :size => size
    end
    
    x = cursor #setting the cursor so that the bolded part is at the same level as non-bolded. Might consider doing this the way i've handled the main body of the invoices
    
    bounding_box([catx1, cursor - 5], :width => leftwidth) do
    	text "MOBILE:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, x - 5], :width => rightwidth) do
    	text "Test this is please work t t t t t t t t t", :size => size
    end
    
    x = cursor
    
    bounding_box([catx1, cursor - 5], :width => leftwidth) do
    	text "PHONE:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, x - 5], :width => rightwidth) do
    	text "Test this is please work t t t t t t t t t", :size => size
    end
    
    x = cursor
    
    bounding_box([catx1, cursor - 5], :width => leftwidth) do
    	text "EMAIL:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, x - 5], :width => rightwidth) do
    	text "somethingpotentionallylong@hotmail.com", :size => size
    end
    
    ##########################################
    ####### REST OF THE DOCUMENT #############
    ##########################################
    
    
    bounding_box([30, 720], :width => 500) do
    
    
    	image "picture2.png", :width => 80
    
    	move_down 20
    
    	font("Helvetica", :size => 25, :style => :bold) do
     		text "INVOICE"
     	end
    
     	move_down 20
    
     	font("Helvetica", :size => 10, :style => :bold) do
     		text "DATE:"
     	end
    
     	move_down 20
    
     	font("Helvetica", :size => 17, :style => :bold) do
     		text "RECIPIENT ADDRESS"
     	end
    
    	stroke do
    	 # just lower the current y position
    	 horizontal_rule
    	end
    
     	move_down 80
    
     	font("Helvetica", :size => 17, :style => :bold) do
     		text "SERVICES"
     	end
    
    	stroke do
    	 # just lower the current y position
    	 horizontal_rule
    	end
    
     	move_down 370
    
     	font("Helvetica", :size => 17, :style => :bold) do
     		text "TOTAL COSTS"
     	end
    
    	stroke do
    	 # just lower the current y position
    	 horizontal_rule
    	end
    
    	move_down 35
    
    	stroke do
    	 # just lower the current y position
    	 horizontal_rule
    	end
    
    end
    
    ###########USER INPUTS STUFF################
    bounding_box([30, 500], :width => 500) do
    	text "23 Fake Address, \n Placeholder Avenue, \n Unreal"
    end
    
    startx = 30
    starty = 400
    
    if block == nil || block == "" #gets executed if there's no block
      
      lines.each do |x|
        
      unless x[2].nil? #wont run it unless there's a price
      	bounding_box([startx, starty], :width => 500) do
      		text "£" + ( '%.2f' % x[2]) + "", :style => :bold, :align => :right
      	end
      end
      
      
      text_width = 430 # standard width for the text-field
      
      unless x[2].nil?
      	if num_digits(x[2]) > 7 # will reduce the size if the cost is too long
      		to_reduce = num_digits(x[2]) - 7
      		to_reduce.times { text_width -= 7}
      	end
      end
      
    	bounding_box([startx, starty], :width => text_width) do
        if x[0].nil? || x[0] == ""
       		   text x[1]
        else
    		   formatted_text [ 
    	                     { text: x[0], :styles => [:bold] },
    	                     { text: " - " + x[1] }
    	                   ]
        end
    
    	end
    
    	starty = cursor - 7 # changes the start position of the next line
    
      end
      
    else
      
      bounding_box([startx, starty], :width => 500) do
      		text block
      end
      	
    end
    
    bounding_box([35, 14], :width => 500) do
    	text "£" + ('%.2f' % total)
    end
    
  end
  
end
