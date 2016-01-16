class InvalidCodonError <StandardError
end

class Translation
  CODON_LENGTH = 3 # b/c each codon is 3 character long
  PROTEIN_HASH = {'AUG' => 'Methionine', 'UUU' => 'Phenylalanine', 'UUC' => 'Phenylalanine', 'UUA'=> 'Leucine', 'UUG' => 'Leucine', 'UCU'=>'Serine', 'UCC'=>'Serine', 'UCA'=>'Serine', 'UCG'=> 'Serine', 'UAU'=>'Tyrosine', 'UAC'=> 'Tyrosine', 'UGU'=>'Cystine', 'UGC'=>'Cystine', 'UGG'=> 'Tryptophan', 'UAA'=> 'STOP', 'UAG'=> 'STOP', 'UGA'=> 'STOP'}

  def self.of_codon(string)
    convert_to_protein_name(string)
  end
  
  def self.of_rna(strand)
    raise InvalidCodonError unless valid?(strand) # to rasie this error create a class for it that inherits from StandardError.
    
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
    case string #setting a variable here is not nessessary.
    when 'AUG' then 'Methionine'
    when 'UUU', 'UUC' then 'Phenylalanine'
    when 'UUA', 'UUG' then 'Leucine'
    when 'UCU', 'UCC', 'UCA', 'UCG' then 'Serine'
    when 'UAU' , 'UAC' then 'Tyrosine'
    when 'UGU' ,'UGC' then 'Cystine'
    when 'UGG' then 'Tryptophan'
    when 'UAA','UAG', 'UGA' then 'STOP'
    end
  end
 
  def self.valid?(strand)
    string_seperator(strand).first == PROTEIN_HASH.keys.any? # return true/false not nessessary b/c the double equal boolean does that for you
  end
  
  def self.string_seperator(strand)
    strand_arr = strand.chars.each_slice(3).map(&:join)
  end
  
end
