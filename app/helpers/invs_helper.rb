include ApplicationHelper
module InvsHelper
  
  
  
  
  def makepdf(inv, display=false) #display is used by the iframe method to only show the pdf and not download it

    
    
    if File.directory?("invoices") == false #makes the invoices folder if it doesn't exist
      Dir.mkdir("invoices")
    end
    
    if File.directory?(inv.user.name) == false #makes a folder for the user in the invoices folder if it doesn't exist
      FileUtils::mkdir_p "invoices/" + inv.user.name
    end
  
    Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
      pdf_method(inv)
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
