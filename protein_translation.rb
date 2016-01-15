class Translation
  CODON_LENGTH = 3 # b/c each codon is 3 character long

  def self.of_codon(string)
   convert_to_protein_name(string)
  end
  
  def self.of_rna(strand)
    
    raise InvalidCodonError, "Strand must contain codon strings only" unless valid?(strand)
    
    codons = string_seperator(strand) 
    index = 0
    seperation_of_codons = strand.length / CODON_LENGTH
    
    seperation_of_codons.times do
      protein_name = convert_to_protein_name(codons[index])
      index +=1
      codons << protein_name
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
    return true if string_seperator(strand).first == (convert_to_protein_name(string_seperator(strand).first))
    return false
  end
  
  def self.string_seperator(strand)
    strand_arr = []
    strand_arr = strand.chars.each_slice(3).map(&:join)
    strand_arr
  end
end


