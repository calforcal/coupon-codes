require "./app/services/holiday_service"
require "./app/poros/holiday"

class HolidayBuilder
  def self.service
    HolidayService.new
  end

  def self.build_holidays
    holidays = []
    5.times { |i| holidays << Holiday.new(service.holidays[i])}
    holidays
  end
end