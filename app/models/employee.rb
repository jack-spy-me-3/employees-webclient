class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthdate, :addresses

  HEADER = { "Accept" => "application/json",
             "X-User-Email" => ENV['API_EMAIL'],
             "Authorization" => "Token token=#{ENV['API_KEY']}"}
  def initialize(hash)
    @id = hash["id"]
    @first_name = hash["first_name"]
    @last_name = hash["last_name"]
    @email = hash["email"]
    @birthdate = hash["birthdate"]
    @addresses = hash["addresses"]
  end

  def self.find_by(input_options)
    id = input_options[:id]
    employee_hash = Unirest.get("#{ENV['API_URL']}employees/#{id}", headers: HEADER).body
    Employee.new(employee_hash)
  end

  def self.all
    employee_hashes = Unirest.get("#{ENV['API_URL']}employees", headers: HEADER).body
    employees = []
    employee_hashes.each do |employee_hash|
      employees << Employee.new(employee_hash)
    end
    employees
  end

  def destroy
    Unirest.delete("#{ENV['API_URL']}employees/#{self.id}", headers: HEADER).body
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def update(input_options)
    employee_hash = Unirest.patch("#{ENV['API_URL']}employees/#{self.id}",
                         headers: HEADER, parameters: input_options).body
    Employee.new(employee_hash)
  end

  def self.create(input_options)
    employee_hash = Unirest.post("#{ENV['API_URL']}employees",
                                 headers: HEADER, 
                                 parameters: input_options).body
    Employee.new(employee_hash)
  end
end
