function HK = HuffCode(HL,Display)
% HuffCode    Based on the codeword lengths this function find the Huffman codewords
%
% HK = HuffCode(HL,Display);
% HK = HuffCode(HL);
% ------------------------------------------------------------------
% Arguments:
%  HL     length (bits) for the codeword for each symbol 
%         This is usually found by the hufflen function
%  HK     The Huffman codewords, a matrix of ones or zeros
%         the code for each symbol is a row in the matrix
%         Code for symbol S(i) is: HK(i,1:HL(i))
%         ex: HK(i,1:L)=[0,1,1,0,1,0,0,0] and HL(i)=6 ==> 
%             Codeword for symbol S(i) = '011010'
%  Display==1  ==> Codewords are displayed on screen, Default=0
% ------------------------------------------------------------------

if nargin<1
   error('huffcode: see help.')
end
if nargin<2
  Display = 0;
end
if (Display ~= 1)
   Display = 0;
end

N=length(HL);
L=max(HL);
HK=zeros(N,L);
[HLs,HLi] = sort(HL);
Code=zeros(1,L); 
for n=1:N
   if (HLs(n)>0)
      HK(HLi(n),:) = Code;
      k = HLs(n);
      while (k>0)                 % actually always!  break ends loop
         Code(k) = Code(k) + 1;
         if (Code(k)==2)
            Code(k) = 0;
            k=k-1;
         else
            break
         end
      end
   end
end

if Display
   for n=1:N
      Linje = ['  Symbol ',int2str(n)];
      for i=length(Linje):15
         Linje = [Linje,' '];
      end
      Linje = [Linje,'  gets code: '];
      for i=1:HL(n)
         if (HK(n,i)==0)
            Linje = [Linje,'0'];
         else
            Linje = [Linje,'1'];
         end
      end
      disp(Linje);
   end
end         
   
return;
   
   
