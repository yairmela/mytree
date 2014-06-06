class Link < ActiveRecord::Base
	has_many :users

  @@dbConn = nil

  def initialize(attributes = nil, options = {})

    Rails.logger.debug "\n***************************************************\n"

    super


    if (@@dbConn == nil)

      @@dbConn = PG.connect(:dbname => 'links_dev', :port => 5432, :password => 777, :user => 'postgres')
    end

  end

  def testDB

    #Rails.logger.debug "^^^^^^^^^^^^^^^^^^^^^^^^^^ #{self.name} - start ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    #Rails.logger.debug self.name

    q = "select * from links where id != #{id}"

    #Rails.logger.debug q


    results = @@dbConn.exec(q)

    #Rails.logger.debug results.to_yaml

    results.each do |result|
      Rails.logger.debug result['name']
    end

    #Rails.logger.debug "^^^^^^^^^^^^^^^^^^^^^^^^^^ #{self.name} - end ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n"
  end
end
