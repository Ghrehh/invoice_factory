include ApplicationHelper

module InvsHelper
  
  
  def makepdf(inv, display=false) #display is used by the iframe method to only show the pdf and not download it
    address_arr = [inv.recipient,inv.address_1,inv.address_2,inv.address_3]
    top_arr = [inv.user.address, inv.user.mobile, inv.user.phone, inv.user.invoice_email]
    
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
        to_push = [] #holds each line and pushes it to the line array, will only push service and price if they're not nil
 
        to_push << x.service 
        to_push << x.description
        to_push << x.price

        lines << to_push
        total += x.price unless x.price.nil?
      end
  
      total = inv.total unless inv.total.nil?
      
      Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
        make_invoice(lines, total, nil, address_arr, top_arr, inv.user.topoffset, inv.user)
      end
      
    ############>>>BLOCK METHOD<<<<<<##############  
    
    else
      unless inv.total.nil?
        total = inv.total 
      else
        total = 0
      end
      
      Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
        make_invoice(lines, total, inv.block, address_arr, top_arr, inv.user.topoffset, inv.user)
      end
      
    end
    
    if display 
      showpdf(inv) #shows the file instead of downloading it
    else
      downloadpdf(inv) #sends the file for download after it's created
    end
    
  end
  
  
  def showpdf(inv)
    send_file(
      "#{Rails.root}/invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf",
      filename: "invoice" + inv.id.to_s +  ".pdf", :disposition => 'inline', 
      type: "application/pdf"
    )
  end
  
  def downloadpdf(inv)
    send_file(
      "#{Rails.root}/invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf",
      filename: "invoice" + inv.id.to_s +  ".pdf", 
      type: "application/pdf"
    )
  end


end
