local sentence = "The,quicks, brown fox jumps over the lazy dog."
for word in sentence:match(',') do
	print(word)
end
