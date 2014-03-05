module Assets

  require 'sass'
  require 'coffee-script'

  @map = {}
  @root = nil

  def self.root root=nil
    if root
      @root = root
      Sass.load_paths << "#{@root}/css"
      watching = ['.js', '.css', '.sass', '.scss', '.coffee']
      Dir.glob("#{root}/**/*").each do |p|
        next unless File.file? p
        next unless watching.include? File.extname(p)
        @map[p] = self.map p
      end
    else
      @root
    end
  end

  def self.map path
    data = read path
    ft = type path
    rp = path.gsub(root, '')
    rp = rp.gsub(File.extname(rp), '')
    rp += ".#{ft}" unless path =~ /\.[a-z]$/
    return({
      includes: includes(data, ft),
      type: ft,
      relative_path: rp 
      })
  end

  def self.add path
    @map[path] = self.map path
    prepare_compile path
  end

  def self.delete path
    @map.delete path
    changed = self.changes(path)
    changed.delete path
    prepare_compile changed
  end


  def self.modify path
    @map[path] = self.map path
    prepare_compile path
  end

  def self.changes path
    fname = File.basename path
    relative_path = path.gsub(root, '')
    if fname =~ /^_/
      # es included
      relative_path = relative_path.gsub(/^\/(css|js)\//, '')
      relative_path = relative_path.gsub(File.extname(relative_path), '')
      should_change = @map.select {|p,d| d[:includes].include? relative_path}
    else
      should_change = @map.select {|p,d| d[:includes].include? relative_path}
      should_change[path] = @map[path]
    end
    #puts should_change
    should_change
  end

  def self.prepare_compile path
    changed = changes(path)
    changed.map do |p, data|
      begin
        data[:result] = compile(p, data)
      rescue Exception => e
        puts "Can't compile #{p}"
        puts e
        puts e.backtrace
      end
    end
    changed
  end


  def self.compile path, data
    contents = read path
    if data[:type] == :css
      return Sass.compile contents, options(:css)
    else
      included = []
      data[:includes].each do |inc|
        d = @map[inc] || self.map(inc)
        included << compile(inc, d)
      end

      path = full_path path unless path.include? root
      source = contents
      source = CoffeeScript.compile(contents, options(:js)) if path =~ /\.coffee$/
      return included.join("\n")+source
    end

  end


  @options = {js: {bare: true}, css: {style: :compressed}}
  def self.options type, data=nil
    if data
      @options[type] = @options[type].merge data
    else
      @options[type]
    end
  end

  def self.full_path path
    Dir["#{$root}/**/#{path}*"][0]
  end

  def self.read path
    path = full_path path unless path.include? root
    File.open(path).read
  end

  def self.includes data, file_type
    data.scan(expression(file_type)).flatten
  end

  def self.type path
    path = full_path path unless path.include? root
    return :js if path =~ /\.(js|coffee)$/
    return :css if path =~ /\.(s?css|sass)$/
  end

  def self.expression type
    case type
      when :js
        exp = /#= require\s+([\w]+)/
      when :css
        exp = /@import\s+"([^"]+)";/
    end

    exp
  end


end