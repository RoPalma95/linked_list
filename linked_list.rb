require 'pry'

class LinkedList
  private

  attr_writer :head, :tail, :size

  public

  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  private

  def create_node(value, index = nil)
    node = Node.new(value, index)
    self.size += 1
    node
  end

  public

  def append(value) # adds new node containing 'value' to the end of the list
    node = create_node(value)
    node.index = size
    if head.nil?
      self.head = node
      self.tail = head
    else
      self.tail.next_node = node
      self.tail = node
    end
  end

  def prepend(value) # adds new node containing 'value' to the start of the list
    node = create_node(value)
    node.index = 1
    node.next_node = head
    if head.nil?
      self.head = node
      self.tail = head
    else
      self.head = node
    end
    adjust_indices("p")
  end

  def insert_at(value, index) # inserts the node with the provided 'value' at the given 'index'
    if index > (size + 1)
      puts "Index has to be #{size + 1} or lower."
    elsif index == (size + 1)
      self.append(value)
    elsif index == 1
      self.prepend(value)
    else
      previous_node = self.at(index - 1)
      new_node = create_node(value, index)
      next_node = self.at(index)
      previous_node.next_node = new_node
      new_node.next_node = next_node
      adjust_indices("i", next_node)
    end
  end

  def at(index) # return the node at the given index
    if index > size
      "Index #{index} does not exist."
    else
      current_node = head
      until current_node.index == index
        current_node = current_node.next_node
      end
      current_node
    end
  end

  def pop() # removes the last element from the list
    current_node = head
    (size - 2).times do
      current_node = current_node.next_node
    end
    self.tail = current_node
    tail.next_node = nil
    self.size -= 1
  end

  def contains?(value) # boolean, true if the passed 'value' is in the list
    current_node = head
    until current_node.nil? || current_node.value == value
      current_node = current_node.next_node
    end
    current_node.nil? ? false : true
  end

  def find(value) # return index of the node containing 'value'
    if self.contains?(value)
      current_node = head
      until current_node.value == value
        current_node = current_node.next_node
      end
      current_node.index
    else
      "Value #{value} does not exist."
    end
  end

  def adjust_indices(insert_method, next_node = nil) # fixes indices after prepending or inserting an element
    if insert_method == 'p'
      current_node = head.next_node
      until current_node.nil?
        current_node.index += 1
        current_node = current_node.next_node
      end
    else
      until next_node.nil?
        next_node.index += 1
        next_node = next_node.next_node
      end
    end
  end

  def to_s # represent LinkedList objects as strings: "( value ) -> ( value ) -> ( value ) -> nil"
    if size == 0
      puts 'The list is empty.'
    else
      current_node = head
      (size - 1).times do 
        print"( #{current_node.value} ) -> "
        current_node = current_node.next_node
      end
      "( #{tail.value} ) -> nil"
    end
  end
end

class Node
  attr_accessor :value, :next_node, :index

  def initialize(value = nil, index = nil)
    @value = value
    @next_node = nil
    @index = index
  end
end

my_list = LinkedList.new
my_list.append(1)
my_list.append(2)
my_list.prepend(3)
my_list.append(4)
my_list.append(5)
my_list.prepend(6)
my_list.insert_at(7, 2)
my_list.pop

puts my_list
puts my_list.size
