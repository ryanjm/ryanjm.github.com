time = Time.now
time_stamp = time.strftime("%Y-%m-%d")

puts "Post name:"
name = gets

fname = "./_posts/#{time_stamp}-#{name.downcase.gsub(" ","-").strip}.md"

puts "fname: #{fname}"

File.open(fname,"w") do |f|
  f.write("---\n")
  f.write("layout: post\n")
  f.write("---\n")
end

%x[open #{fname} -a /Applications/MacVim.app]


