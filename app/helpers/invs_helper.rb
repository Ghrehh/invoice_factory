module InvsHelper
  
  
  def makepdf(inv)
    
    ##############################################
      #######DIRECTORY MAKING SECTION###########
    #############################################
    
      if File.directory?("invoices") == false #makes the invoices folder if it doesn't exist
        Dir.mkdir("invoices")
      end
      
      if File.directory?(inv.user.name) == false #makes a folder for the user in the invoices folder if it doesn't exist
        FileUtils::mkdir_p "invoices/" + inv.user.name
      end
    
    ###############>>>>LINES METHOD<<<<###################
    
    if inv.block.nil? || inv.block == "" #will use this section if the block method is unused
  
      lines = [] #array that holds each line
      total = 0
      
      inv.lines.each do |x| 
        to_push = "" #holds each line and pushes it to the line array, will only push service and price if they're not nil
        unless x.service == ""
          to_push += x.service + ": "
        end
          to_push += x.description
          
        unless x.price.nil?
          to_push += " ||£" + ('%.2f' % x.price).to_s + "||"
        end
        
        lines << to_push
        total += x.price unless x.price.nil?
      end
  
      total = inv.total unless inv.total.nil?
      
      Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
        text lines.join("\n") + "\n\n" + "Total: £" + ('%.2f' % total).to_s
      end
      
    ############>>>BLOCK METHOD<<<<<<##############  
    else # method used for the block, will only take the custom total
      
      Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
        text inv.block + "\n\n" + "Total: £" + ('%.2f' % inv.total).to_s
      end
      
    end
    
    downloadpdf(inv) #sends the file for download after it's created
    
  end
  
  
  
  def downloadpdf(inv)
    
    send_file(
      "#{Rails.root}/invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf",
      filename: "invoice" + inv.id.to_s +  ".pdf",
      type: "application/pdf"
    )
  
  end
  


end
