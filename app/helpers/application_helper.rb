module ApplicationHelper
  include CoverimagesHelper
  

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
  
def num_digits(num) # gets the length of a fixnum, #need this to get the length of the line cost to readjust the height
  if num > 0
    Math.log10(num).to_i + 1
  else #this lets me get the length of negative numbers
    numstring = num.to_s
    numstring = numstring[1..-1]
    numagain = numstring.to_i
    Math.log10(numagain).to_i + 2
  end
end



  def pdf_method(inv)
    
    @inv = inv
    @block = inv.block
    @user = @inv.user
    @address_arr = [inv.recipient,inv.address_1,inv.address_2,inv.address_3] #creates the ne
    @top_arr = [@user.address, @user.mobile, @user.phone, @user.invoice_email]
    @top_offset = @user.topoffset
    @lines = []
    @total = 0
  
  
  
    
    if @block.nil? || @block == "" #makes lines if there's no block yo
    
        
      @inv.lines.each do |x| 
        to_push = [] #holds each line and pushes it to the line array, will only push service and price if they're not nil
  
        to_push << x.service 
        to_push << x.description
        to_push << x.price
  
        @lines << to_push
        @total += x.price unless x.price.nil?
      end
      
    else
      
      @total = @inv.total unless @inv.total.nil? #will asign the total to the custom one unless it's nil
      
    end
    
      
  
    
    
    @top_offset = 0 if @top_offset == nil #santizes top offset
    
    top_arr_fixed = [] #top array sanitise.
    @top_arr.each do |x|
      x = "" if x.nil?
      top_arr_fixed << x
    end
    
    
    catx1 = 180 + @top_offset # coords for the top right stuff
    catx2 = 370 + @top_offset
    
    leftwidth = 185
    rightwidth = 160
    
    size = 9
    
    
    bounding_box([catx1, 720], :width => leftwidth) do
    	text "ADDRESS:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, 720], :width => rightwidth) do
    	text top_arr_fixed[0], :size => size
    end
    
    x = cursor #setting the cursor so that the bolded part is at the same level as non-bolded. Might consider doing this the way i've handled the main body of the invoices
    
    bounding_box([catx1, cursor - 5], :width => leftwidth) do
    	text "MOBILE:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, x - 5], :width => rightwidth) do
    	text top_arr_fixed[1], :size => size
    end
    
    x = cursor
    
    bounding_box([catx1, cursor - 5], :width => leftwidth) do
    	text "PHONE:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, x - 5], :width => rightwidth) do
    	text top_arr_fixed[2], :size => size
    end
    
    x = cursor
    
    bounding_box([catx1, cursor - 5], :width => leftwidth) do
    	text "EMAIL:", :style => :bold, :align => :right, :size => size
    end
    
    bounding_box([catx2, x - 5], :width => rightwidth) do
    	text top_arr_fixed[3], :size => size
    end
    
    
    
    bounding_box([20, 720], :width => 500) do
    
      #need to make a method thatll check if
      if @user.coverimages.first.nil? #if theres no cover image uploaded will use the black placeholder
    	  image "picture2.png", :height => 80
    	else
    	  
        if File.directory?("coverimages/" + @user.name + "/" + @user.coverimages.first.filename) == false #checks if heroku hasn't deleted the image
          write_to_tree(@user.coverimages.first) #remakes the image
        end
        
        image "coverimages/" + @user.name + "/" + @user.coverimages.first.filename, :height => 80
      end
      	
    	
    	move_down 20
    
    	font("Helvetica", :size => 25, :style => :bold) do
     		text "INVOICE"
     	end
    
     	move_down 55
      
     	font("Helvetica", :size => 17, :style => :bold) do
     		text "RECIPIENT"
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
  
    
    
    #if the address fields are nil this turns them into an empty string
    address_arr_fixed = []
    
    @address_arr.each do |x|
      x = "" if x.nil?
      address_arr_fixed << x
    end
    
    address = address_arr_fixed.join("\n")
    
    
    
    ###########USER INPUTS STUFF################
    bounding_box([25, 567], :width => 500) do
    	text "DATE:", :style => :bold, :size => 10
    end
    
    bounding_box([25, 506], :width => 500) do
    	text address
    end
    
    startx = 25
    starty = 400
    
    if @block == nil || @block == "" #gets executed if there's no block
      
    
      @lines.each do |x|
        
        unless x[2].nil? #wont run it unless there's a price
        	bounding_box([startx, starty], :width => 500) do
        		text "£" + ( '%.2f' % x[2]) + "", :style => :bold, :align => :right
        	end 
        end
        
        
        text_width = 420 # standard width for the text-field
        
        unless x[2].nil? || x[2] == 0 
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
      		text @block
      end
      	
    end
    
    bounding_box([25, 14], :width => 500) do
    	text "£" + ('%.2f' % @total)
    end
    
  end
  
  
end


