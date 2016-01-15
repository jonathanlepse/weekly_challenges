class Translation
  CODON_LENGTH = 3 # b/c each codon is 3 character long

  def self.of_codon(string)
   convert_to_protein_name(string)
  end
  
  def self.of_rna(strand)
    
    raise "Invalid Codon Error" unless valid?(strand)
    
    range_start = 0
    range_end = 2
    seperation_of_codons = strand.length / CODON_LENGTH
    num = 0 
    codons = []
    
    seperation_of_codons.times do
      codons[num] = strand[range_start..range_end]
      range_start +=3
      range_end +=3
      codons[num +=1]
    end
    
    codons.map! do |element|
      convert_to_protein_name(element)
    end
    codons
  end
  
  protected
  
  def self.convert_to_protein_name(string)
    conversion = case string
      when 'AUG' then 'Methionine'
      when 'UUU', 'UUC' then 'Phenylalanine'
      when 'UUA', 'UUG' then 'Leucine'
      when 'UCU', 'UCC', 'UCA', 'UCG' then 'Serine'       
      when 'UAU' , 'UAC' then 'Tyrosine'
      when 'UGU' ,'UGC' then 'Cystine'
      when 'UGG' then 'Tryptophan'
      when 'UAA','UAG', 'UGA' then 'STOP'
      end
    conversion
  end
 
  def self.valid?(strand)
    strand_arr = strand.chars.each_slice(3).map(&:join)
    return true if strand_arr == (convert_to_protein_name(strand_arr[0]))
    return false
  end
end


