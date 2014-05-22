module SimulatorTests 


	def test_list 
		puts "New Simulation"
		puts
		my_simulation = Simulation.new
		puts "Create Politician Joe Bidden, Democrat"
		puts 
		joe_bidden = Politician.new("Joe Bidden", "Democrat")
		puts "Create Voter Lucky Luciano, Socialist"
		puts
		lucky_luciano = Voter.new("Luck Luciano", "Socialist")
		puts "Let's see the list of all people"
    puts my_simulation.list
	end 



	def test_create 
   

    my_simulation = Simulation.new

  
		puts
		my_simulation.send(:create)
		puts
		my_simulation.send(:list) 
    puts
		my_simulation.send(:create)
		puts
		my_simulation.send(:list)
		puts
		my_simulation.send(:create)
		puts
		my_simulation.send(:list)
	end 

	def test_update

		my_simulation = Simulation.new
		Voter.new("Joe Smith", "Liberal")
		Voter.new("Mike Suarez", "Conservative")
		Voter.new("Lorenzo Gamio", "Progressive")
		Politician.new("Joe Garcia", "Republican")
		Politician.new("Elaine Kagan", "Democrat")
		Politician.new("Mike Koch", "Republican")
		my_simulation.send(:update)

		
 		
 		puts
    puts "Lets see all our Voters in list format"
    puts my_simulation.send(:list)
    puts
		# puts "Now as an array of objects"
		# p Voter.voters_created
		my_simulation.send(:update)
		puts
		puts my_simulation.send(:list)
		puts
		my_simulation.send(:update)
		puts
		puts my_simulation.send(:list)


	end

	def test_vote
		my_simulation = Simulation.new
		Voter.new("Joe Smith", "Liberal")
		Voter.new("Mike Suarez", "Conservative")
		Voter.new("Lorenzo Gamio", "Socialist")
		Voter.new("Mike Jones", "Tea Party")
		Voter.new("Don Draper", "Neutral")
		Voter.new("Peggy Olson", "Liberal")
		Voter.new("Roger Sterling", "Conservative")
		Voter.new("Joan Harris", "Socialist")
		Voter.new("Pete Campbell", "Tea Party")
		Voter.new("Betty Draper", "Neutral")
		Voter.new("Ken Cosgrove", "Liberal")
		Voter.new("Burt Cooper", "Conservative")
		Voter.new("Harry Crane", "Socialist")
		Voter.new("Bob Benson", "Tea Party")
		Voter.new("Megan Draper", "Neutral")
		Politician.new("Joe Garcia", "Republican")
		Politician.new("Elaine Kagan", "Democrat")
  	Politician.new("Mike Koch", "Republican")
    my_simulation.send(:vote)


	end 

	def test_main_menu
		my_simulation = Simulation.new
		my_simulation.main_menu

	end 

def test_stump

		Voter.new("Joe Smith", "Liberal")
		Voter.new("Mike Suarez", "Conservative")
		Voter.new("Lorenzo Gamio", "Socialist")
		Voter.new("Mike Jones", "Tea Party")
		Voter.new("Don Draper", "Neutral")
		Voter.new("Peggy Olson", "Liberal")
		Voter.new("Roger Sterling", "Conservative")
		Voter.new("Joan Harris", "Socialist")
		Voter.new("Pete Campbell", "Tea Party")
		Voter.new("Betty Draper", "Neutral")
		Voter.new("Ken Cosgrove", "Liberal")
		Voter.new("Burt Cooper", "Conservative")
		Voter.new("Harry Crane", "Socialist")
		Voter.new("Bob Benson", "Tea Party")
		Voter.new("Megan Draper", "Neutral")
		Politician.new("Joe Garcia", "Republican")
		Politician.new("Elaine Kagan", "Democrat")
  	Politician.new("Mike Koch", "Republican")



	end 

end 
