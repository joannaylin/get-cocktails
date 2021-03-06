require_relative '../config/environment'

def space
  puts ""
  puts "- - - - - - - - - - - - -"
  puts ""
end

def drink1 
  puts <<-'EOF'
      *   *  .  *     
      ..  *   o             
    o   *  .   *      
      * .  .o *
     ________               
    (________)                  
    |    o   |                              
    |   o    |                               
    | o    o |                        
    | o  o   |                            
    |      o |                                             
    ( o      )                         
     \   o  /                                      
      \    /                                     
       \  /                              
        ||                                        
        ||                                 
        ||                              
        ||                         
     ___||___                            
    /   ||   \                         
    \________/                         
  EOF
end

def drink2
  puts <<-'EOF'          
   *                           )   *
                          )        (                   (
                (          )     (             )
           )    *           )        )  (
          (                (        (      *           
           )          H     )       
                     [ ]            (
              (  *   |-|       *     )    (
        *      )     |_|        .         
              (      | |    .  
        )           /   \     .    ' .        *
       (           |_____|  '  .    .  
                   | ___ |  \~~~/  ' .   ( 
               *   | \ / |   \_/  \~~~/   )
                   | _Y_ |    |    \_/   
       *     jgs   |-----|  __|__   |      
                   `-----`        __|__    
  EOF
end

def drink3
  puts <<-'EOF'
  .
  .
 . .
  ...
\~~~~~/
 \   /
  \ /
   V
   |
   |
  ---
  EOF
end


def welcome
  puts "#{drink1}"
  pastel = Pastel.new
  puts pastel.italic.cyan("What is your name?")
  name = gets.chomp
  if name.match(/^[[:alpha:][:blank:]]+$/)
    if User.where("name like ?", "%#{name}%").first
      user = User.where("name like ?", "%#{name}%").first
    else
      user = User.create(name: name)
    end
      pastel = Pastel.new
      puts pastel.italic.cyan("Welcome to The Cocktail App, #{user.name}.")
      user
  else
    puts "This name isn't valid. Please try again:"
    welcome
  end
end

def main_menu(user)
  space
  answer = TTY::Prompt.new.select("What would you like to do?") do |menu|
    menu.enum '.'
    menu.choice 'Search cocktails by name', 1
    menu.choice 'Search cocktails by ingredient', 2
    menu.choice 'See your favorite cocktails', 3
    menu.choice 'Update a rating for one of your favorite cocktails', 4
    menu.choice 'Delete a cocktail from your favorites', 5
    menu.choice 'Exit the program', 6
  end

  case answer
    when 1
      user.search_cocktails
      main_menu(user)
    when 2
      user.search_ingredients
      main_menu(user)
    when 3
      user.print_saved_cocktails
      main_menu(user)
    when 4
      user.update_rating
      main_menu(user)
    when 5
      user.delete_favorite
      main_menu(user)
    when 6
      user.leave
    end
end

def run
  font = TTY::Font.new(:doom)
  puts Pastel.new.cyan(font.write("The Cocktail App"))
  user = welcome
  main_menu(user)
end

run