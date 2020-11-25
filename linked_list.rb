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

  def create_node(value)
    node = Node.new(value)
    node.pointer = node
    self.size += 1
    node
  end

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
    adjust_indices
  end

  def at(index) # return the node at the given index
    if index > size
      "Index #{index} does not exist."
    else
      current_node = head
      until current_node.index == index
        current_node = current_node.next_node
      end
      current_node.value
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

  def adjust_indices # fixes indices after prepending an element
    current_node = head.next_node
    until current_node.nil?
      current_node.index += 1
      current_node = current_node.next_node
    end
  end

  def to_s # represent LinkedList objects as strings: "( value ) -> ( value ) -> ( value ) -> nil"
    if size == 0
      puts 'The list is empty.'
    else
      current_node = head
      (size - 1).times do 
        print"(#{current_node.value}) -> "
        current_node = current_node.next_node
      end
      "(#{tail.value}) -> nil"
    end
  end
end

class Node
  attr_accessor :value, :pointer, :next_node, :index

  def initialize(value = nil)
    @value = value
    @pointer = nil
    @next_node = nil
    @index = nil
  end
end

my_list = LinkedList.new
my_list.append('A')
my_list.append('B')
my_list.prepend('b')
my_list.append('C')
my_list.append('D')
my_list.prepend('a')
# my_list.pop
# my_list.pop
# my_list.pop

# p my_list.head
puts my_list.contains?('A')
puts my_list.contains?('B')
puts my_list.contains?('C')
puts my_list.contains?('D')
puts my_list.contains?('E')
puts my_list.contains?('a')
puts my_list.contains?('b')
puts my_list.contains?('c')
puts my_list.contains?('d')
puts my_list.size
