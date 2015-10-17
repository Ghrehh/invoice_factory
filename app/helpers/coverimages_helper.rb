module CoverimagesHelper
  
  def write_to_tree(image)
    
      if File.directory?("coverimages") == false #makes the coverimages folder if it doesn't exist
        Dir.mkdir("coverimages")
      end
      
      if File.directory?("coverimages/" + image.user.name) == false #makes a folder for the user in the invoices folder if it doesn't exist
        FileUtils::mkdir_p "coverimages/" + image.user.name
      end
      
    File.open("coverimages/" + image.user.name + "/" + image.filename, 'wb') do |f|
      f.write(image.file_contents)
    end
  end
  
  def delete_image(image)
    File.delete("coverimages/" + image.user.name + "/" + image.filename)
  end
  
end
