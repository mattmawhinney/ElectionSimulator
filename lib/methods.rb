require 'pp'
require '../test/test_simulator.rb'

include SimulatorTests 


class Simulation 
  
  def initialize
    puts
    puts "Welcome to Democratopia--an American electoral simulator."
    puts "Today, you are the puppet master behind the machinery of a model American election."
    puts "In this simulation, you have the ability to create voters and politicians,"
    puts "list out your voters and politicians, update your list of voters and politicians,"
    puts "and run an election simulation."
    puts 
    puts "Before you can run a simulation, you need to create at least 3 voters and 2 politicians."
    main_menu
  end 

  private 

  def main_menu
    
    voters = Voter.voters_created
    politicians = voters.select {|voter| voter if voter.is_a? Politician}
    puts
    action = ""
    until action == "1" || action == "2" || action == "3" || action == "4"
      puts "What would you like to do?" 
      puts "[1]Create"
      puts "[2]List" 
      puts "[3]Update" 
      puts "[4]Vote"
      prompt 
      action = gets.chomp
      puts
    end
    
    #flawed, need to correct
    while true 
      if action == "4" && voters.length >= 3 && politicians.length >= 1 
        vote 
      elsif action == "4" && voters.length < 3 
        puts "You need to create at least three voters and two politicians."
        main_menu
      elsif action == "1"
        create
      elsif action == "2" && voters.length >= 1 
        list 
      elsif action == "2" && voters.length < 1
        puts "There is no list yet."
        main_menu
      elsif action == "3" && voters.length >= 1 
        update
      elsif action == "3" && voters.length < 1 
        puts "You need to create a voter or politician before you can update." 
        main_menu
      end
    end 
  end 

  #working 
  def create
    puts 

    input = ""
    until input == "1" || input == "2"
      puts "What would you like to create?" 
      puts "[1]Politician" 
      puts "[2]Voter"
      prompt
      input = gets.chomp
    end
      
    if input == "1"
      puts "Name?"
      prompt 
      name = gets.chomp.split(' ').map {|word| word.capitalize}.join(' ')
      puts 
      
      party = ""
      until party == "1" || party == "2"
        puts "Party?" 
        puts "[1]Democrat" 
        puts "[2]Republican" 
        prompt
        party = gets.chomp
      end
      
      if party == "1"
        party = "Democrat"
      elsif party == "2"
        party = "Republican"
      end 
     
      Politician.new(name,party)
    
    elsif input == "2"
      puts "Name?"
      prompt 
      name = gets.chomp.split(' ').map {|word| word.capitalize}.join(' ')
      puts 
      
      politics = ""
      until politics == "1" || politics == "2" || politics == "3" || politics == "4" || politics == "5"
        puts "Politics?" 
        puts "[1]Liberal" 
        puts "[2]Conservative" 
        puts "[3]Tea Party" 
        puts "[4]Socialist"  
        puts "[5]Neutral"
        prompt
        politics = gets.chomp
      end

      if politics == "1"
        politics = "Liberal"
      elsif politics == "2"
        politics = "Conservative"
      elsif politics == "3"
        politics = "Tea Party"
      elsif politics == "4"
        politics = "Socialist"
      elsif politics == "5"
        politics = "Neutral"
      end
        
      Voter.new(name,politics)
    end 
     
    main_menu
  end

  #working 
  def list 
  	#access the array of all objects created at change to name, party/politics 
    puts
    puts Voter.voters_created.map {|voter| "#{voter.name}, #{voter.class == Politician ? voter.party : voter.politics}"} 
    main_menu
  end

  def voted_reset
    all_voters = Voter.voters_created
      all_voters.each do |voter|
        voter.voted = false
      end 
  

  end

  #working 
  def update
  	puts

    voter_list = Voter.voters_created.map {|voter| "#{voter.name}, #{voter.class == Politician ? voter.party : voter.politics}"}
    voter_list_as_objects = Voter.voters_created

    name = "*%$***"
    #searches for inputed name in list of voters 
    #needs to be improved because it doesn't require an exact match and could lead
    #to incorrect updating
    until voter_list.map {|list_item| list_item[0..name.length-1] == name }.include? true
      puts "Name?" 
      prompt
      name = gets.chomp.split(' ').map {|word| word.capitalize}.join(' ')
 		end  
   		
    puts
 		puts "New name?"
 		prompt	
 		new_name = gets.chomp.split(' ').map {|word| word.capitalize}.join(' ') 
    
    #find index at which given voter name occurs, so we access that voter object below 
    index = voter_list_as_objects.find_index {|instance| instance.name == name } 
  
  	#find out whether voter is just a voter or a politician as well
 		if ((voter_list_as_objects[index].is_a? Voter) && !(voter_list_as_objects[index].is_a? Politician))
 			puts
      new_politics = "*%$***"
      until new_politics == "1" || new_politics == "2" || new_politics == "3" || new_politics == "4" || new_politics == "5"
   			puts "Politics?" 
        puts "[1]Liberal" 
        puts "[2]Conservative" 
        puts "[3]Tea Party" 
        puts "[4]Socialist"  
        puts "[5]Neutral"
        prompt
   			new_politics = gets.chomp 
      end

      if new_politics == "1"
        new_politics = "Liberal"
      elsif new_politics == "2"
        new_politics = "Conservative"
      elsif new_politics == "3"
        new_politics = "Tea Party"
      elsif new_politics == "4"
        new_politics = "Socialist"
      elsif new_politics == "5"
        new_politics = "Neutral"
      end


      #reset voters politics 
 			voter_list_as_objects[index].politics = new_politics
 		elsif voter_list_as_objects[index].is_a? Politician
 			puts
      new_party = "*%$***"
      until new_party == "1" || new_party == "2"
   			puts "New Party?" 
        puts "[1]Democrat" 
        puts "[2]Republican"
        prompt
   			new_party = gets.chomp
      end

      if new_party == "1"
        new_party = "Democrat"
      elsif new_party == "2"
        new_party = "Republican"
      end 

      #rest politicians party 
 		voter_list_as_objects[index].party = new_party
 		end

    #reset voter/politicians name 
 		voter_list_as_objects[index].name = new_name
    
    main_menu
  end

  #kind of working but needs imporvement   
  def vote 
  	
    voters = Voter.voters_created
   
    politicians = Voter.voters_created.select {|voter| voter if voter.is_a? Politician}
    vote_count = Hash.new(0)
    who_voted_for_whom = Hash.new(0)
    #introduce an element of fairness by varying when candidates get to visit voters 
    campaign_stops = politicians.product(voters).shuffle

    campaign_stops.each do |stump_speech|
      campaigner = stump_speech[0]
      campaignee = stump_speech[1]

      campaigner.stump(campaignee)
       
      #need way to cancel out votes 

      if campaignee.cast_vote(campaigner)
        puts "\tYou bet!"
        vote_count[campaigner.name] += 1
        who_voted_for_whom[campaignee.name] = campaigner.name
        puts
      elsif campaignee.voted == true 
        puts "\tSorry, I've already voted"
        puts
      elsif campaignee.cast_vote(campaigner) && (campaigner == campaignee)
        puts "\tI am #{campaigner.name}, and I am voting for myself!"
        vote_count[campaigner.name] += 1 
        who_voted_for_whom[campaignee.name] = campaigner.name
        puts
      elsif  ( !campaignee.cast_vote(campaigner) ) &&  ( !campaignee.is_a? Politician )
        puts "\tI am not persuded by your logic"
        puts
      end 
    end 

    sorted_vote_count = vote_count.to_a.sort {|a,b| b[1] <=> a[1]}
    puts
    puts
    puts "\t\tWINNER"
    puts "\tAnd the winner is #{sorted_vote_count[0][0]}!"
    puts "\t\tWINNER"
    puts
    puts "\tAnd because this is a transparent democracy, here's the vote totals:"
    puts 
    puts "\t#{vote_count}"
    puts
    puts "\tAnd let's see who voted for whom so we can purge the disloyal."
    puts
    puts "\t#{who_voted_for_whom}"

    voted_reset
    main_menu
  end
    
  	
    
  ###############helpers##############
  def prompt 
  	print "> "
  end

  #####################################


end


class Voter
  
  attr_accessor :name, :politics, :voted
	#@@? to keep track of voters_created created ? 
  @@voters_created = []

	def initialize(name,politics)
		@name = name 
		@politics = politics 
    @voted = false 
    @@voters_created << self

	end 

	def self.voters_created
		@@voters_created
  end


  # need to randomly pick a number not included in the rand
  def cast_vote(politician)
  	if ((self.is_a? Voter) && !(self.is_a? Politician) && (self.voted == false))
  		if politician.party == "Democrat"
  	    if ((self.politics == "Socialist") && ((1..90).include? rand(100) + 1))
          self.voted = true
          return true
  			end
  			if ((self.politics == "Liberal") && ((1..75).include? rand(100) + 1))
          self.voted = true
          return true
  			end
  			if ((self.politics == "Neutral") && ((1..50).include? rand(100) + 1))  	
          self.voted = true
          return true
  			end
  			if ((self.politics == "Conservative") && ((1..25).include? rand(100) + 1))
          self.voted = true
          return true
  			end
  			if ((self.politics == "Tea Party") && ((1..10).include? rand(100)+ 1))
          self.voted = true
          return true
  			end
  		elsif politician.party == "Republican"
  			if ((self.politics == "Tea Party") && ((1..90).include? rand(100) + 1))
           self.voted = true
           return true
  			end
  			if ((self.politics == "Conservative") && ((1..75).include? rand(100) + 1))
          self.voted = true
          return true
  			end
  			if ((self.politics == "Neutral") && ((1..50).include? rand(100) + 1))
          self.voted = true
          return true
  			end
  			if ((self.politics == "Liberal") && ((1..25).include? rand(100) + 1))
          self.voted = true
          return true
  			end
  			if ((self.politics == "Socialist") && ((1..10).include? rand(100)+ 1))
          self.voted = true
          return true
  			end
  		end     
  	elsif ((self.is_a? Voter) && (self.is_a? Politician))
  		if self == politician
        self.voted = true
  			return true 
  		end 
    else 
      return false
    end
  end	
end  



class Politician < Voter

	attr_accessor :party, :voted
	
	def initialize(name,party) 
		@name = name 
  	@party = party
  	@voted = false 
  	@@voters_created << self

	end

  def stump(voter)
    
    if (self.is_a? Politician) && ((voter.is_a? Voter)  && !(voter.is_a? Politician))
        #&& (campaignee.voted == false) removed from conditional above
        #only allows a voter to vote once, but before meeting all candidates
        puts <<-STUMPSPEECH
        Howdy there constituent #{voter.name}!
        You are #{voter.politics}.
        I'm #{self.name}, and I'm a #{self.party}.
        Can I count on your vote?

        STUMPSPEECH
    elsif (self.is_a? Politician) && (voter.is_a? Politician) && (self.party == voter.party) && (self != voter)
        puts <<-BRUSHOFF
        Howdy there #{voter.name}!
        I'm #{self.name}, a #{self.party}.
        You are a fellow member of the #{self.party} party!
        Though I largely agree with you on all issues,
        I will latch on to a trivial distinction in 
        our policy stances to justify opposing and villifying you.
        If you should, however, win this election, 
        please consider me for an appointment to high office.

        BRUSHOFF
    elsif (self.is_a? Politician) && (voter.is_a? Politician) && (self.party != voter.party)
        puts <<-DENNUNCIATION
        #{self.name}! You vile #{self.party}!
        How can you dream of aspiring to higher office 
        in this great land of ours?
        You most certainly eat babies and torture puppies!
        Fie on you and your political aspirations.
        I, #{voter.name} shall crush you in the present electoral contest!

        DENNUNCIATION
    end #(campaigner.is_a? Politician) && ((campaignee.is_a? Voter) && !(campaignee.is_a? Politician))
  end #campaign 
end 

