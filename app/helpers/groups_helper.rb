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
        
        if y.block.nil? || y.block == "" #will use this section if the block method is unused
          lines = []
          total = 0
          
          y.lines.each do |x| 
            to_push = "" #holds each line and pushes it to the line array, will only push service and price if they're not nil
            unless x.service == ""
              to_push += x.service + ": "
            end
              to_push += x.description
              
            unless x.price.nil?
              to_push += " ||£" + x.price.to_s + "||"
            end
            
            lines << to_push
            total += x.price unless x.price.nil?
          end
          
          total = y.total unless y.total.nil?
          
          text lines.join("\n") + "\n\n" + "Total: £" + total.to_s
          
        else #block rendering
         
          text y.block + "\n\n" + "Total: £" + y.total.to_s
      
        end
        
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
