close all %fecha todas as janelas abertas de execuções anteriores
clear all %fecha todas as variáveis abertas de execuções anteriores

% selecionando imagem
im = imread('C:\Users\usuario\Desktop\imagens_selecionadas\imagem1.jpg');

% diametro da moeda em milimetros
diametro = 22;

% reduzindo tamano da imagem e gerando im2
l = 1;
for(i = 1:2:size(im,1))
  c = 1;
  for(j = 1:2:size(im,2))  
    im2(l,c,1) = im(i,j,1);
    im2(l,c,2) = im(i,j,2);
    im2(l,c,3) = im(i,j,3);
    c++;
  endfor
  l++;
endfor
%
% gerando imagem binaria
for(i=1:size(im2,1))
  for(j=1:size(im2,2))
    if(im2(i,j,1)>110 && im2(i,j,2)>105 && im2(i,j,3)>80)
      im_bin(i,j)=0;
    else
      im_bin(i,j)=1;
    endif
  endfor
endfor
%
% reduzindo tamano da imagem binaria e gerando im_bin2
l = 1;
for(i = 1:2:size(im_bin,1))
  c = 1;
  for(j = 1:2:size(im_bin,2))  
    im_bin2(l,c) = im_bin(i,j);
    c++;
  endfor
  l++;
endfor
%
% reduzindo tamano da im_bin2 e gerando im_bin3
l = 1;
for(i = 1:2:size(im_bin2,1))
  c = 1;
  for(j = 1:2:size(im_bin2,2))  
    im_bin3(l,c) = im_bin2(i,j);
    c++;
  endfor
  l++;
endfor
%
%fazendo copia de im_bin3 para im_bin4
im_bin4 = im_bin3;

% removendo ruidos do fundo da imagem im_bin4
for(l=2:size(im_bin3,1)-1)
  for(c=2:size(im_bin3,2)-1)
    if(im_bin3(l,c)==1) 
      if(im_bin3(l-1,c) == 0 && im_bin3(l,c-1)==0 && im_bin3(l,c+1)==0 && im_bin3(l+1,c)==0)
        im_bin4(l,c) = 0;     
      endif
    endif
  endfor
endfor
for(l=5:size(im_bin3,1)-3)
  for(c=5:size(im_bin3,2)-3)
    if(im_bin3(l,c)==1) 
      
      if(im_bin3(l-3,c) == 0 && im_bin3(l,c-3)==0 && im_bin3(l,c+3)==0 && im_bin3(l+3,c)==0)
        im_bin4(l,c) = 0;     
      endif
    endif
  endfor
endfor
%
% removendo ruidos de dentro da moeda e da folha da imagem im_bin4
for(l=2:size(im_bin3,1)-1)
  for(c=2:size(im_bin3,2)-1)
    if(im_bin3(l,c)==0) 
      if(im_bin3(l-1,c) == 1 && im_bin3(l,c-1)==1 && im_bin3(l,c+1)==1 && im_bin3(l+1,c)==1)
        im_bin4(l,c) = 1;     
      endif
    endif
  endfor
endfor
for(l=5:size(im_bin3,1)-3)
  for(c=5:size(im_bin3,2)-3)
    if(im_bin3(l,c)==0) 
      if(im_bin3(l-3,c) == 1 && im_bin3(l,c-3)==1 && im_bin3(l,c+3)==1 && im_bin3(l+3,c)==1)
        im_bin4(l,c) = 1;     
      endif
    endif
  endfor
endfor
% copiando as imagens para arquivos diferentes

% marcando cordenadas inicial e final das linhas da primeira imagem encontrada
l_inicio = 0;
l_fim = 0;
for(i = 1:size(im_bin4,1))
  if(im_bin4(i,:) == 0)
  else
    l_inicio = i;
    break;
  endif
endfor
for(i = l_inicio:size(im_bin4,1))
  if(im_bin4(i,:) == 0)
    l_fim = i-1;
    break;
  endif
endfor
%
% marcando as cordenadas inicial e final das colunas da primeira imagem encontrada
c_inicio = 0;
c_fim = 0;
for(i = 1:size(im_bin4,2))
  if(im_bin4(:,i) == 0)
  else
    c_inicio = i;
    break;
  endif
endfor
for(i = c_inicio:size(im_bin4,2))
  if(im_bin4(:,i) == 0)
    c_fim = i-1;
    break;
  endif
endfor
%
% copiando a primeira imagem para um arquivo chamado obj1
l = 1;
for(i = l_inicio:l_fim)
  c = 1;
  for(j = c_inicio:c_fim)  
    obj1(l,c) = im_bin4(i,j);
    c++;
  endfor
  l++;
endfor
%
% marcando as cordenadas das linhas inicial e final da segunda imagem
l_inicio2 = 0;
l_fim2 = 0;
for(i = l_fim + 5:size(im_bin4,1))
  if(im_bin4(i,:) == 0)
  else
    l_inicio2 = i;
    break;
  endif
endfor
for(i = l_inicio2:size(im_bin4,1))
  if(im_bin4(i,:) == 0)
    l_fim2 = i-1;
    break;
  endif
endfor
%
% marcando as cordenadas das colunas inicial e final da segunda imagem
c_inicio2 = 0;
c_fim2 = 0;
for(i = c_fim + 5:size(im_bin4,2))
  if(im_bin4(:,i) == 0)
  else
    c_inicio2 = i;
    break;
  endif
endfor
for(i = c_inicio2:size(im_bin4,2))
  if(im_bin4(:,i) == 0)
    c_fim2 = i-1;
    break;
  endif
endfor
%
% copiando a segunda imagem para o arquivo obj2
l = 1;
for(i = l_inicio2:l_fim2)
  c = 1;
  for(j = c_inicio2:c_fim2)  
    obj2(l,c) = im_bin4(i,j);
    c++;
  endfor
  l++;
endfor
%
% fazendo as medicoes em milimetros
tamanho_pixel_mm = diametro / size(obj1,2);
largura_obj2 = size(obj2,2) * tamanho_pixel_mm;
altura_obj2 = size(obj2,1) * tamanho_pixel_mm;

% verificando em qual combinacao de medidas a imagem se encontra

% identificando goiaba
if(largura_obj2 > 70 && largura_obj2 < 130 && altura_obj2 >30 && altura_obj2 <60)
  printf("goiaba");

% identificando manga
elseif(largura_obj2 >130 && largura_obj2 <240 && altura_obj2 >30 && altura_obj2 <50)
  printf("manga");

% identificando caju
elseif(largura_obj2 > 110 && largura_obj2 < 190 && altura_obj2 > 65 && altura_obj2 < 94)
  printf("caju");
endif
% exibindo imagens
figure(1);
imshow(im);

figure(2);
imshow(im2);

figure(3);
imshow(im_bin);

figure(4);
imshow(im_bin2);

figure(5);
imshow(im_bin3);

figure(6);
imshow(im_bin4);

figure(7);
imshow(obj1);

figure(8);
imshow(obj2);