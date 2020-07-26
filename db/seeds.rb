
(1..100).each do|number|
Task.create(content: 'ruby content1' + number.to_s)
end