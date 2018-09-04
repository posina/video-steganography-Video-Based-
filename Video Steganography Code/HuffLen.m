function HL = HuffLen(S)
% HuffLen     Find the lengths of the Huffman code words
% Based on probability (or number of occurences) of each symbol 
% the length for the Huffman codewords are calculated.
% 
% HL = hufflen(S);
% ------------------------------------------------------------------
% Arguments:
%  S  a vector with number of occurences or probability of each symbol
%     Only positive elements of S are used, zero (or negative)
%     elements get length 0.
%  HL length (bits) for the codeword for each symbol 
% ------------------------------------------------------------------
% Example:
% hufflen([1,0,4,2,0,1])  =>  ans = [3,0,1,2,0,3]
% hufflen([10,40,20,10])  =>  ans = [3,1,2,3]

if nargin<1
   error('HuffLen: see help.')
end
% some checks and exceptions
if (length(S)==0)          % ver 1.2
   warning('HuffLen: Symbol sequence is empty.');   % a warning is appropriate
   HL=0;
   return;
end
I=find(S<0);
S(I)=0;
if (sum(S)==max(S))
   disp('HuffLen: Only one symbol.');   % a message is appropriate
   HL=zeros(size(S));       % no Huffman code is needed
   return;
end

HL=zeros(size(S));  
S=S(:);
Ip=find(S>0);       % index of positive elements
Sp=S(Ip);           % the positive elements of S

N=length(Sp);       % elements in Sp vector
HLp=zeros(size(Sp));    
C=[Sp(:);zeros(N-1,1)];  % count or weights for each "tree"
Top=1:N;                 % the "tree" every symbol belongs to
[So,Si]=sort(-Sp);       % Si is indexes for descending symbols
last=N;                  % Number of "trees" now
next=N+1;                % next free element in C 
while (last > 1)
   % the two smallest "trees" are put together
   C(next)=C(Si(last))+C(Si(last-1));
   I=find(Top==Si(last));
   HLp(I)=HLp(I)+1;   % one extra bit added to elements in "tree"
   Top(I)=next;
   I=find(Top==Si(last-1));
   HLp(I)=HLp(I)+1;   % and one extra bit added to elements in "tree"
   Top(I)=next;
   last=last-1;                 
   Si(last)=next;
   next=next+1;
   % Si shall still be indexes for descending symbols or nodes
   count=last-1;
   while ((count> 0) & (C(Si(count+1)) >= C(Si(count))))
      temp=Si(count);
      Si(count)=Si(count+1);
      Si(count+1)=temp;
      count=count-1;
   end
end

HL(Ip)=HLp;
return;

