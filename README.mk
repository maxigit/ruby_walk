
# Introduction
This gem provides the ability to *walk* recursively amongs an object and its dependencies, ie executing a optional block and storing the result in a flat list.
The dependecies are give as hash associating a class and its dependencies (a list of symbols to call on the object).
The `walk_objects` methods can be used either to generate a flat list of an object and its dependencies or to just to iterate over them.

## Examples
Lets consider a Rails like example

    Class User
      has_many :posts
    end

    Class Post
      :has_many :comments
    end


    user.walk_objects(:user => [:posts], :posts =>[:comments])

will generate a list containing, the user, all its posts, and all of the associated comments


## Filtering
to filter the element to be walked use a block. If a block return `nil` then element and its dependencies are skiped. If the result is `[]` the element is not returned in the result but its dependencies are walked.

With the previous example, to get only the list of comments

    user.walk_objects(:user => [:posts], :posts =>[:comments]) { |e| e.is_a?(Comment) ? e : [])

### Walking over a hash
use  `:keys` and or `:values`.

To get all the final value of a Hash



{:a=>1, :b=>2, :c=>{:a=>3, :d=>5}}.walk_objects(Hash => [:values]){ |e| e.is_a?(Hash) ? [] : e }
>>
[1, 2, 3, 5]