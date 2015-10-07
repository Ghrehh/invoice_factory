

module InvsHelper
  
  def makepdf(inv)
  
    lines = []
    total = 0
    inv.lines.each do |x| 
      lines << x.service + ": " + x.description + " ||£" + x.price.to_s + "||" 
      total += x.price
    end
    
    if File.directory?("invoices") == false
      Dir.mkdir("invoices")
    end
    
    if File.directory?(inv.user.name) == false
      FileUtils::mkdir_p "invoices/" + inv.user.name
    end
    
    
    Prawn::Document.generate("invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf") do
      text lines.join("\n") + "\n\n" + "Total: £" + total.to_s
    end
    
    downloadpdf(inv)
    
  end
  
  
  
  def downloadpdf(inv)
    
    send_file(
      "#{Rails.root}/invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf",
      filename: "invoice" + inv.id.to_s +  ".pdf",
      type: "application/pdf"
    )
  
  end

end
