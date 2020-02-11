%% =================================================================

% This script compares low-rank tensor completion methods
% listed as follows:
%     1. TMac       
%     2. LRTC-TV-I     
%     3. LRTC-TV-II          
%     4. SPC-QV        
%     5. TNN           t-SVD based method                                                                                                                                                       
%     6. NL-LRTC       our proposed model
% You can:
%     1. Type 'Demo_LRTC' to to run various methods and see the pre-computed results.
%     2. Select competing methods by turn on/off the enable-bits in Demo_LRTC.m
%
% More detail can be found in [1]
% [1] Xiao-Tong Li, Xi-Le Zhao, Tai-Xiang Jiang, Yu-Bang Zheng, Teng-Yu Ji, Ting-Zhu Huang, 
%     Low-rank tensor completion via combined non-local self-similarity and low-rank regularization
%
% Please make sure Your data is in range [0, 1].
%
% Created by Xiao-Tong Li  lixiaotong0283@163.com
% 1/3/2019

%% =================================================================
