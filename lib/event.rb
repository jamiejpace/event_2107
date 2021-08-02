class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map do |food_truck|
      food_truck.name
    end
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |food_truck|
      food_truck.inventory.include?(item)
    end
  end

  def total_inventory
    inventory = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, quantity|
        trucks_with_item = @food_trucks.find_all do |food_truck|
          food_truck.inventory.include?(item)
        end
        if inventory[item].nil?
          inventory[item] = {:quantity => quantity, :food_trucks => trucks_with_item}
        else
          inventory[item][:quantity] += quantity
        end
      end
    end
    inventory
  end

  def overstocked_items
    overstocked = []
    total_inventory.values.each do |value|
      if value[:quantity] > 50 && value[:food_trucks].length > 1
        overstocked << total_inventory.key(value)
      end
    end
    overstocked
  end
end
