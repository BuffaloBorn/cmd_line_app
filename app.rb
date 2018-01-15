require "thor"

class App < Thor
 desc "hello WORD", "Print 'Hello, WORD' to the screen."
 def hello word
  puts "Hello #{word}"
 end

 desc "list_recipes [KEYWORD][OPTIONS]", "List all recipes. If the keyword is given, it filters the list based off it"
 option :format, required: true
 option :show_time, type: :boolean, default:true #--show-time --no-show-time
 def list_recipes keyword=nil
	

        recipes = [
	 { 
            title: "Ratatouille",
            cooking_time: "60 min",
            ingredients: %w{potatoes carrots onions zucchini tomatoes}
          }, 
	    {
            title: "Mac & Cheese",
            cooking_time: "20 min",
            ingredients: %w{macarroni cheese onions mustard milk}
          }, 
	    {
            title: "Caesar Salad",
            cooking_time: "10 min",
            ingredients: %w{chicken lettuce croutons eggs}
          }
	]

	
        recipes_to_be_listed = if keyword.nil? then recipes
                               else recipes.select {|recipe| recipe[:title].downcase.include? keyword.downcase}

			       end


	recipes_to_be_listed.each do |recipe|
	 if options[:format].nil?
	  print_default recipe	
	 else options[:format] == "oneline"
	  print_oneline recipe
	 end
	end

			         
 end

 private 

  def print_default recipe
	puts "--------------------"
	puts "Recipe: #{recipe[:title]}"
	puts "It takes: #{recipe[:cooking_time]} to cook"
	puts "The ingredients are: #{recipe[:ingredients].join(", ")}"
	puts ""
  end

  def print_oneline recipe
     if options[:show_time]
        time = "(#{recipe[:cooking_time]})"
     else
	time =""
     end
	puts %Q{#{recipe[:title]} #{time}}
  end

end

App.start ARGV
