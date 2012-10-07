% zClassifyPairs(File) calculates the rotation matrix, axis, angle, and shift
% between bases in File that are close enough to possibly be interacting, then
% classifies the interaction

function [File] = zClassifyPairs(File)

if isfield(File,'Pair'),
  File = rmfield(File,'Pair');                  % remove previous pair info
end

if File.NumNT > 0,

t = cputime;

CL = zClassLimits;                              % read ClassLimits matrix

if exist('PairExemplars.mat','file') > 0,
  load('PairExemplars','Exemplar');
else
  Exemplar = [];
end

% -------- First screening of base pairs ------------------------------------ 

DistCutoff = 10.5;                                % max distance for interaction
[i,j] = find((File.Distance < DistCutoff).*(File.Distance > 0)); 
                                                % screen by C-C distance
k = find(i<j);                                  % look at each pair only once
i = i(k);                                       % reduce list of indices
j = j(k);                                       % reduce list of indices

fprintf('Classifying %5d pairs of bases for interactions\n', length(i));

% -------- Screen and analyze base pairs ------------------------------------ 
% 1-AA  2-CA  3-GA  4-UA  5-AC  6-CC  7-GC  8-UC 
% 9-AG 10-CG 11-GG 12-UG 13-AU 14-CU 15-GU 16-UU

pc = 1;                                         % index for pairs

for k = 1:length(i),                            % loop through possible pairs

  Ni = File.NT(i(k));                           % nucleotide i information
  Nj = File.NT(j(k));                           % nucleotide j information

  [Pair,s] = zClassifyPair(Ni,Nj,CL,Exemplar);

  if ~isempty(Pair),

    if (s == 1),
      Pair.Base1Index = i(k);                       % bases in original order
      Pair.Base2Index = j(k);
      File.Edge(i(k),j(k)) =  Pair.Edge;
      File.Edge(j(k),i(k)) = -Pair.Edge;
    else
      Pair.Base1Index = j(k);                       % bases in reversed order
      Pair.Base2Index = i(k);
      File.Edge(i(k),j(k)) = -Pair.Edge;
      File.Edge(j(k),i(k)) =  Pair.Edge;
    end
 
    % --------------------------- code class to distinguish AA, CC, ... cases

    if (Ni.Code == Nj.Code) & (abs(Pair.Class) < 15),
      if i(k) > j(k),
        Pair.Class = -Pair.Class;                  
        % negative indicates that the lower-indexed base uses the dominant edge
      end
    end

    % --------------------------- record interaction

    File.Inter(i(k),j(k)) = Pair.Class;             % record this interaction
    File.Inter(j(k),i(k)) = Pair.Class;

    File.Pair(pc) = Pair;                           % store in File data

    pc = pc + 1;                                    % increment pair counter

  end
end   % loop over pairs

if pc > 1,                                         % if pairs were found
  A = cat(1, File.Pair(:).Base1Index);
  B = cat(1, File.Pair(:).Base2Index);
  C = min(A,B);

  [y,ii] = sort(C);

  File.Pair = File.Pair(ii);                       % order by lower base index
else
  File.Pair = [];
end

%fprintf('Found %5d pairs that are possibly interacting\n', pc-1);

fprintf('Classification took %4.2f minutes, or %4.0f classifications per minute\n', (cputime-t)/60, 60*(length(i))/(cputime-t));

else                                                % no nucleotides
  File.Pair = [];
end