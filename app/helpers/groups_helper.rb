module GroupsHelper
  
  def makepdfgroup(group)
    
        ##############################################
      #######DIRECTORY MAKING SECTION###########
    #############################################
  
    
    if File.directory?("invoices") == false
      Dir.mkdir("invoices")
    end
    
    if File.directory?(group.user.name) == false
      FileUtils::mkdir_p "invoices/" + group.user.name
    end
    
    group_length = group.invs.count
      
    Prawn::Document.generate("invoices/" + group.user.name + "/invoice" + group.id.to_s +  ".pdf") do
      group.invs.each_with_index do |y, y2|

        pdf_method(y)
        
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
