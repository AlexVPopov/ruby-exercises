# Abomination

Да се напише клас `Abomination`, който да има следното поведение:

Конструкторът му приема непразен списък от обекти (винаги ще бъде подаден поне един обект):

    a = Abomination.new 5, 'foo', [1, 2], :bar

Инстанциите на класа `Abomination` трябва да отговарят на всички методи, на които отговарят подадените при конструиране обекти:

    a.abs           # => 5     (от 5.abs)
    a.gsub 'o', 'a' # => 'faa' (от 'foo'.gsub 'o', 'a')
    a.join ','      # => "1,2" (от [1, 2].join ',')

Ако един метод го има в няколко обекта, то превес взима обектът, който е по-напред в списъка:

    a.to_s # => '5' (от 5.to_s)
    a.length # => 3   (от 'foo'.length)

Ако поисканият метод го няма никъде, то се вдига `NoMethodError`:

    a.foo # NoMethodError: undefined method `foo' for a:Abomination

Освен това, предефинирайте `is_a?` метода, така че `Abomination` обектите да се представят като всеки от подадените обекти:

    a.is_a? Fixnum      # => true
    a.is_a? String      # => true
    a.is_a? Symbol      # => true
    a.is_a? Float       # => false
    a.is_a? Abomination # => true

Предполагам, че няма нужда да се казва, че такива извращения в реална система много рядко са смислена идея. Като toy example обаче са супер :-)

_Hint_: Тъй като по същество `Abomination` е proxy, чудесна идея е да наследява от `BasicObject`, за да има по-малко пречкащи ви се методи:

    class Abomination < BasicObject
      # ...
    end
