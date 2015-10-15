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
        
        address_arr = [y.recipient, y.address_1,y.address_2,y.address_3]
        top_arr = [y.user.address, y.user.mobile, y.user.phone, y.user.invoice_email]
        ##############################################
        ###############>>>>LINES METHOD<<<<###################
        ##############################################
        
        if y.block.nil? || y.block == "" #will use this section if the block method is unused
          lines = []
          total = 0
          
          y.lines.each do |x| 
            to_push = [] #holds each line and pushes it to the line array, will only push service and price if they're not nil

            to_push << x.service 
            to_push << x.description
            to_push << x.price

            lines << to_push
            total += x.price unless x.price.nil?
          end
          
          total = y.total unless y.total.nil?
          
          make_invoice(lines, total, nil, address_arr, top_arr)
          
            ##############################################  
            ############>>>BLOCK METHOD<<<<<<############## 
            ##############################################
          
        else #block rendering
        
          unless y.total.nil?
            total = y.total 
          else
            total = 0
          end
          
            make_invoice(lines, total, y.block, address_arr, top_arr)
      
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
      filename: "invoice" + inv.id.to_s +  ".pdf", :disposition => 'inline',
      type: "application/pdf"
    )
  end
  
end
