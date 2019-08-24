class NumberController < ActionController::API
    def convertDecimal
        decimal_param = params[:decimal]

        roman_number = DecimalToRoman.to_roman(decimal_param.to_i)
        render json:{decimal: decimal_param, roman: roman_number}
    end
    
end


class DecimalToRoman
    RN = {
      100 => 'C',
      50 => 'L',
      10 => 'X',
      5 => 'V',
      1 => 'I'  
    }
  
    def self.to_roman(decimal)
      return nil if decimal > 100 || decimal < 1
      return to_roman_loop(decimal)
    end
  
    def self.to_roman_loop(dec)
      roman_base = 100
      result = ''
      while (dec > 0) do
        factor = dec/roman_base
        result << multiple_of(factor, roman_base)
        dec -= (factor*roman_base)
        roman_base /= 10
      end
      result
    end
  
    def self.multiple_of(factor, roman_base)
      case factor
      when 0
        ''
      when 1..3
        RN[roman_base]*factor
      when 4
        RN[roman_base] + RN[roman_base*5]
      when 5
        RN[roman_base*5]
      when 6..8
        RN[roman_base*5] + (RN[roman_base]*(factor-5))
      when 9
        RN[roman_base] + RN[roman_base*10]
      else
        raise "Error"
      end
    end
  end