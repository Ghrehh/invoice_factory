include ApplicationHelper

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
        to_push = [] #holds each line and pushes it to the line array, will only push service and price if they're not nil
 
        to_push << x.service 
        to_push << x.description
        to_push << x.price

        lines << to_push
        total += x.price unless x.price.nil?
      end
  
      total = inv.total unless inv.total.nil?
      
      Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
        make_invoice(lines, total)
      end
      
    ############>>>BLOCK METHOD<<<<<<##############  
    
    else
      unless inv.total.nil?
        total = inv.total 
      else
        total = 0
      end
      
      Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
        make_invoice(lines, total, inv.block)
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
