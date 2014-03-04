class String

  def clean!
    self.strip!
    self.gsub!(/\s+/, ' ')
    self  
  end

  def clean
    self.dup.clean!
  end

end