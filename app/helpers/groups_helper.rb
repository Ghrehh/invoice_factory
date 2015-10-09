module GroupsHelper
  
  def makepdfgroup(group)
  
    
    if File.directory?("invoices") == false
      Dir.mkdir("invoices")
    end
    
    if File.directory?(group.user.name) == false
      FileUtils::mkdir_p "invoices/" + group.user.name
    end
    
    group_length = group.invs.count
      
    Prawn::Document.generate("invoices/" + group.user.name + "/invoice" + group.id.to_s +  ".pdf") do
      group.invs.each_with_index do |y, y2|
        lines = []
        total = 0
        
        y.lines.each do |x| 
          lines << x.service + ": " + x.description + " ||£" + x.price.to_s + "||" 
          total += x.price
        end
        
        text lines.join("\n") + "\n\n" + "Total: £" + total.to_s
        
        if y2 != group_length - 1
          start_new_page 
        end
        
      end
      
    end
    download_pdf_group(group)
    
  end
  
  
  
  def download_pdf_group(inv)
    
    send_file(
      "#{Rails.root}/invoices/" + inv.user.name + "/invoice" + inv.id.to_s +  ".pdf",
      filename: "invoice" + inv.id.to_s +  ".pdf",
      type: "application/pdf"
    )
    
  end
  
  
end
