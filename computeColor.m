function [img, rad] = computeColor(u,v,colorwheel)

%   computeColor color codes flow field U, V

%   According to the c++ source code of Daniel Scharstein 
%   Contact: schar@middlebury.edu

%   Author: Deqing Sun, Department of Computer Science, Brown University
%   Contact: dqsun@cs.brown.edu
%   $Date: 2007-10-31 21:20:30 (Wed, 31 Oct 2006) $

% Copyright 2007, Deqing Sun.
%
%                         All Rights Reserved
%
% Permission to use, copy, modify, and distribute this software and its
% documentation for any purpose other than its incorporation into a
% commercial product is hereby granted without fee, provided that the
% above copyright notice appear in all copies and that both that
% copyright notice and this permission notice appear in supporting
% documentation, and that the name of the author and Brown University not be used in
% advertising or publicity pertaining to distribution of the software
% without specific, written prior permission.
%
% THE AUTHOR AND BROWN UNIVERSITY DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
% INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY
% PARTICULAR PURPOSE.  IN NO EVENT SHALL THE AUTHOR OR BROWN UNIVERSITY BE LIABLE FOR
% ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE. 

nanIdx = isnan(u) | isnan(v);
u(nanIdx) = 0;
v(nanIdx) = 0;

%colorwheel = makeColorwheel();
ncols = size(colorwheel, 1);

rad = sqrt(u.^2+v.^2);          

a = atan2(-v, -u)/pi;

fk = (a+1) /2 * (ncols-1) + 1;  % -1~1 maped to 1~ncols
   
k0 = floor(fk);                 % 1, 2, ..., ncols

k1 = k0+1;
k1(k1==ncols+1) = 1;

f = fk - k0;

% Only storing Blue Channel data to get the backward motion

for i = 1:size(colorwheel,2)
    tmp = colorwheel(:,i);
    col0 = tmp(k0)/255;
    col1 = tmp(k1)/255;
    col = (1-f).*col0 + f.*col1;   
   
    idx = rad <= 1;   
  %  col(idx) = 1-rad(idx).*(1-col(idx));    % increase saturation with radius
    
  %  col(~idx) = col(~idx)*0.75;             % out of range
    
    img(:,:, i) = uint8(floor(255*col.*(1-nanIdx)));         
end;    

