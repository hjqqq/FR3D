
function [Text] = zIsostericSubgroups(c1,c2,categ)

% Table 1 (cis WC/WC):   %This does not consider G/U and A/C equivalent to 
% the canonical cis WC
M{1,1,1}='I4';    M{1,2,1}='i2';    M{1,3,1}='I3';    M{1,4,1}='I1';
M{2,1,1}='I2';    M{2,2,1}='I6';    M{2,3,1}='I1';    M{2,4,1}='I5';
M{3,1,1}='I3';    M{3,2,1}='I1';    M{3,3,1}='I0';    M{3,4,1}='i2';
M{4,1,1}='I1';    M{4,2,1}='I5';    M{4,3,1}='I2';    M{4,4,1}='I6';

%Table 2 {trans WC/WC}:
M{1,1,2}='I4';    M{1,2,2}='I3';    M{1,3,2}='I0';    M{1,4,2}='I1';
M{2,1,2}='I3';    M{2,2,2}='I6';    M{2,3,2}='I2';    M{2,4,2}='I5';
M{3,1,2}='I0';    M{3,2,2}='I2';    M{3,3,2}='I4';    M{3,4,2}='I3';
M{4,1,2}='I1';    M{4,2,2}='I5';    M{4,3,2}='I3';    M{4,4,2}='I6';

%Table 3 {cis WC/H}:
M{1,1,3}='I0';    M{1,2,3}='I0';    M{1,3,3}='I3';    M{1,4,3}='(I3)';
M{2,1,3}='I0';    M{2,2,3}='I2';    M{2,3,3}='I1';    M{2,4,3}='(I1)';
M{3,1,3}='I3';    M{3,2,3}='I0';    M{3,3,3}='I4';    M{3,4,3}='I0';
M{4,1,3}='I1';    M{4,2,3}='I0';    M{4,3,3}='I1';    M{4,4,3}='I2';

%Table 4 {trans WC/H}:
M{1,1,4}='I4';    M{1,2,4}='I0';    M{1,3,4}='I4';    M{1,4,4}='I0';
M{2,1,4}='I2';    M{2,2,4}='I1';    M{2,3,4}='I2';    M{2,4,4}='I0';
M{3,1,4}='I0';    M{3,2,4}='I0';    M{3,3,4}='I5';    M{3,4,4}='I4';
M{4,1,4}='I1';    M{4,2,4}='I0';    M{4,3,4}='I3';    M{4,4,4}='I2';

%Table 5 {cis WC/SE}:
M{1,1,5}='I1';    M{1,2,5}='I1';    M{1,3,5}='I1';    M{1,4,5}='I1';
M{2,1,5}='I2';    M{2,2,5}='I2';    M{2,3,5}='I2';    M{2,4,5}='I2';
M{3,1,5}='(I3)';  M{3,2,5}='I3';    M{3,3,5}='I5';    M{3,4,5}='I3';
M{4,1,5}='I4';    M{4,2,5}='(I4)';  M{4,3,5}='I4';    M{4,4,5}='(I4)';

%Table 6 {trans WC/SE}:
M{1,1,6}='I1';    M{1,2,6}='(I1)';  M{1,3,6}='I1';    M{1,4,6}='(I1)';
M{2,1,6}='I1';    M{2,2,6}='I1';    M{2,3,6}='I1';    M{2,4,6}='(I1)';
M{3,1,6}='I0';    M{3,2,6}='I2';    M{3,3,6}='I0';    M{3,4,6}='I2';
M{4,1,6}='I3';    M{4,2,6}='I3';    M{4,3,6}='I4';    M{4,4,6}='(I3)';

%Table 7 {cis H/H}:
M{1,1,7}='I0';    M{1,2,7}='I0';    M{1,3,7}='I2';    M{1,4,7}='I0';
M{2,1,7}='I0';    M{2,2,7}='I0';    M{2,3,7}='I1';    M{2,4,7}='I0';
M{3,1,7}='I2';    M{3,2,7}='I1';    M{3,3,7}='I1';    M{3,4,7}='I0';
M{4,1,7}='I0';    M{4,2,7}='I0';    M{4,3,7}='I0';    M{4,4,7}='I0';

%Table 8 {trans H/H}:
M{1,1,8}='I1';    M{1,2,8}='I1';    M{1,3,8}='I2';    M{1,4,8}='I2';
M{2,1,8}='I1';    M{2,2,8}='I0';    M{2,3,8}='I1';    M{2,4,8}='I2';
M{3,1,8}='I2';    M{3,2,8}='I1';    M{3,3,8}='I3';    M{3,4,8}='I0';
M{4,1,8}='I2';    M{4,2,8}='I2';    M{4,3,8}='I0';    M{4,4,8}='I0';

%Table 9 {cis H/SE}:
M{1,1,9}='I1/I2';  M{1,2,9}='I1';    M{1,3,9}='I1';    M{1,4,9}='I1';
M{2,1,9}='I1';    M{2,2,9}='I1/I2';  M{2,3,9}='I1';    M{2,4,9}='I1/I2';
M{3,1,9}='(I1)';    M{3,2,9}='I0';    M{3,3,9}='I1';    M{3,4,9}='I0';
M{4,1,9}='I2';    M{4,2,9}='(I1)';    M{4,3,9}='I1/I2';  M{4,4,9}='I1';

%Table 10 {trans H/SE}:
M{1,1,10}='I1';   M{1,2,10}='I1';   M{1,3,10}='I1';   M{1,4,10}='I1';
M{2,1,10}='I1';   M{2,2,10}='I1';   M{2,3,10}='I0';   M{2,4,10}='I1';
M{3,1,10}='I0';   M{3,2,10}='I0';   M{3,3,10}='I2';   M{3,4,10}='I0';
M{4,1,10}='I2';   M{4,2,10}='I0';   M{4,3,10}='I2';   M{4,4,10}='I0';

%Table 11 {cis SE/SE}:
M{1,1,11}='I1';   M{1,2,11}='I1';   M{1,3,11}='I1';   M{1,4,11}='I1';
M{2,1,11}='I1';   M{2,2,11}='(I1)';   M{2,3,11}='I1';   M{2,4,11}='I1';
M{3,1,11}='I1';   M{3,2,11}='(I1)';   M{3,3,11}='I1';   M{3,4,11}='(I1)';
M{4,1,11}='I1';   M{4,2,11}='I1';   M{4,3,11}='I1';   M{4,4,11}='(I1)';

%Table 12 {trans SE/SE}:
M{1,1,12}='I1';   M{1,2,12}='I1';   M{1,3,12}='I1';   M{1,4,12}='I1';
M{2,1,12}='I0';   M{2,2,12}='I0';   M{2,3,12}='I0';   M{2,4,12}='I0';
M{3,1,12}='(I2)';   M{3,2,12}='I2';   M{3,3,12}='I2';   M{3,4,12}='I2';
M{4,1,12}='I0';   M{4,2,12}='I0';   M{4,3,12}='I0';   M{4,4,12}='I0';

%Table 13 {trans SE/SE}:
M{1,1,13}='I1';   M{1,2,13}='I1';   M{1,3,13}='I0';   M{1,4,13}='I0';
M{2,1,13}='I2';   M{2,2,13}='I3';   M{2,3,13}='I0';   M{2,4,13}='I0';
M{3,1,13}='I0';   M{3,2,13}='I0';   M{3,3,13}='I1';   M{3,4,13}='I1';
M{4,1,13}='I0';   M{4,2,13}='I0';   M{4,3,13}='I0';   M{4,4,13}='I0';

Text = M{c1,c2,categ};

while length(Text) < 5,
  Text = [Text ' '];
end

