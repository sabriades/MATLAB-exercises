classdef bsl
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
%&&&                                                                   &&&&
%&&&                                bsl                                &&&&
%&&&                                                                   &&&&
%&&&    routines per il calcolo di B-Spline uniformi non periodiche    &&&&
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

% Last updated: 01 April 2020 

%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
%
% Corso di Modellazione Geometrica e Prototipazione Virtuale
% Prof. Stanislao Patalano
% a cura di  F. Vitolo - University of Naples
%            P. Franciosa - University of Warwick
%
%&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

    methods (Static)
        %%
        function U=knotsNonPeriodic(n,p)
            % calcola il vettore dei nodi (uniforme-non periodico)
            % INPUT:
            %      n - numero di punti di controllo-1
            %      p - grado della curva ... se p=n si ha una curva di Bezier
            
            U=[]; % inizializza U
            if p>n
                msgbox('P-degree should be less then %d', n)
                return
            end
            
            k=p+1; % ordine della curva
            m=n+k;
            U=zeros(1,m+1);
            
            for i=0:m
                if i<k % prima condizione
                    U(i+1)=0;
                elseif i>=k && i<=n % seconda condizione
                    U(i+1)=i-k+1;
                elseif i>n % terza condizione
                    U(i+1)=n-k+2;
                end
            end
            
            U=U./max(U);
        end
        
        %%
        function spanv=getSpan(U)
            % calcola gli span-knots
            spanv=[];
            for i=1:length(U)-1
                if U(i+1)>U(i)
                    spanv=[spanv;U(i) U(i+1)];
                end
            end
        end
        
        %%
        function spank=findSpanKnot(u,n,U)
            % calcola lo span-knot index
            % u - parametro della curva (u deve appartenere allo span-knot [ui,ui+1[.. estremo destro aperto
            % u è il t=# che il prof dà all'esame e devo verificare a quale
            % intervallo del vettore dei nodi appartiene
            % n - numero di punti di controllo-1
            % U - vettore dei nodi
            
            % spank - span-knot al quale "u" appartiene (0-based')
            % Attenzione - 0-based: il primo intervallo è definito con indice 0. 
            
            % inizializza...
            spank=[];
            
            % caso particolare se u==U(n+2)...==U($-p-1)
            if u==U(n+2)
                spank=n;
                return
            end
            
            Uspan=[U(1:end-1);U(2:end)];
            for i=1:size(Uspan,2)
                if u>=Uspan(1,i) && u<Uspan(2,i)
                    spank=i;
                    spank=spank-1;
                    break
                end
            end
        end
        
        %%
        function N=basicFunctionBspline(i,u,p,n,U)
            % calcola le funzioni di forma non nulle
            % i - span index
            % u - parametro del punto
            % p - grado della curva
            % n - numero di punti di controllo-1
            % U - vettore dei nodi
            % N - vettore delle funzioni di forma [1,n+1]
            % a cosa serve? calcola le funzioni di base relative a t=#
            
            % i=i-1; // zero-based
            
            tN(1)=1;
            
            for j=1:p
                left(j+1)=u-U((i+1-j)+1);
                rigth(j+1)=U((i+j)+1)-u;
                
                saved=0;
                for r=0:j-1
                    temp=tN(r+1)/(rigth((r+1)+1)+left((j-r)+1));
                    tN(r+1)=saved+rigth((r+1)+1)*temp;
                    saved=left((j-r)+1)*temp;
                end
                tN(j+1)=saved;
            end
            
            N=zeros(1,n+1);
            
            N(i-p+1:i+1)=tN';
        end
        
        %%
        function Pbs=getBsplinePoint(Pc,p,U,ulow,uup,res)
            % calcola i punti della B-spline
            % Pc - coordinate dei punti di controllo [n+1,2]
            % U - vettore dei nodi ([1xn+k+1])... k=p+1
            % uup/ulow - intervallo compreso tra [0, 1] nel quale plottare la curva
            % p - grado della curva
            % res - risoluzione della curva
            
            % Pbs - coordinate dei punti della curva B-spline
            
            Pbs=[];
            
            % # di punti di controllo-1
            n=size(Pc,1)-1;
            
            % dimensione dello spazio di lavoro
            nspace=size(Pc,2);
            
            % ordine della curva
            k=p+1;
            
            % vettore parametrico
            u=ulow:(uup-ulow)/(res-1):uup;
            
            % numero di punti complessivi
            nPoint=length(u);
            
            % inizializza l'output
            Pbs=zeros(nPoint,nspace);
            
            % loop over all points
            for point=1:nPoint
                
                % calcola l'indice di appartenenza
                spank=bsl.findSpanKnot(u(point),n,U);
                
                % calcola le funzioni di base
                N=bsl.basicFunctionBspline(spank,u(point),p,n,U);
                
                % aggiorna i punti della curva
                Pbs(point,:)=N*Pc;
            end
        end
        
        %%
        function [Pc,U]=globalCurveInterp(Q,p)
            % interpolazione globale con curva B-spline
            % Q - vettore dei punti da interpolare
            % p - grado della curva B-spline
            % Pc - vettore dei punti di controllo
            % U - vettore dei nodi (uniforme non periodico)
            
            n=size(Q,1)-1;
            
            nc=size(Q,2);
            Pc=zeros(n+1,nc);
            
            % calcola il vettore dei parametri ("chord length alghoritm")
            dt=0;
            for i=1:n
                d(i)=norm(Q(i+1,:)-Q(i,:));
                dt=d(i)+dt;
            end
            
            % normalizzato nell'intervallo [0, 1]
            t(1)=0;
            for i=2:n
                t(i)=t(i-1)+d(i-1)/dt;
            end
            
            t(end+1)=1;
            
            % calcola il knot vector ("average alghoritm")
            m=n+p+1;
            U=zeros(1,m+1);
            
            U(1:p+1)=0;
            U(m-p+1:end)=1;
            
            for j=1:n-p
                U(j+p+1)=sum(t(j+1:j+p))/p;
            end
            
            % inizializza la matrice dei coefficienti
            A=zeros(n+1,n+1);
            
            % fill A rows
            for i=1:n+1
                
                id=bsl.findSpanKnot(t(i),n,U);
                N=bsl.basicFunctionBspline(id,t(i),p,n,U);
                
                A(i,:)=N;
            end
            
            % calcola i punti di controllo di controllo incogniti
            Pc=A\Q; % LU decomposition
        end
        
        %%
        function writePointonFile(filename,Pbs)
            % esporta i punti della curva
            % scrivi i punti della curva su file
            fileID=fopen(filename,'w');
            fprintf(fileID,'%.3f %.3f %.3f\n',Pbs');
            fclose(fileID);
        end
        
        
        %%
        %&&&&&&&&&&&&&&&&&&
        % GRAPHIC UTILITIES
        %&&&&&&&&&&&&&&&&&&
        
        %%
        function createCurve(Pc,p,U,res)
            % Pc - punti di controllo
            % p - grado della curva
            % U - vettore dei nodi
            
            ax=gca();
            
            Uk=bsl.getSpan(U);
            
            % setta le opzioni
            opt.thickness=2;
            opt.color='blue';
            opt.style='-';
            
            ncurve=size(Uk,1);
            for i=1:ncurve
                Pbs=bsl.getBsplinePoint(Pc,p,U,Uk(i,1),Uk(i,2),res);
                
                bsl.drawCurve(Pbs,opt,ax, Pc)
                
                if strcmp(opt.style,'-')
                    opt.style='--';
                elseif strcmp(opt.style,'--')
                    opt.style='-';
                end
                
            end
            
            view(2);
        end
        
        %%
        function drawCurve(Point,opt,ax, Pc)
            % Point - coordinate dei nodi
            % opt - struttura delle opzioni
            % ax - asse corrente
            % Pc - on/off poligono di controllo
            
            if size(Point,2)==2 % se curva 2D aggiungi al terna coordinata
                Point(:,3)=0;
            end
            
            hold all
            
            plot3(Point(:,1),Point(:,2),Point(:,3))
            
            % % assegna le proprietà
            obj=get(ax, 'Children'); % get current entity
            hobj=obj(1);
            hobj.LineWidth=opt.thickness;
            hobj.LineStyle=opt.style;
            hobj.Color=opt.color;
            
            % plotta il poligono di controllo
            if ~isempty(Pc)
                
                if size(Pc,2)==2 % se curva 2D aggiungi al terna coordinata
                    Pc(:,3)=0;
                end
                
                plot3(Pc(:,1),Pc(:,2),Pc(:,3),'k')
                
                % assegna le proprietà
                obj=get(ax, 'Children'); % get current entity
                hobj=(obj(1));
                hobj.LineStyle='-';
                hobj.LineWidth=1;
                hobj.Color='k';
                hobj.Marker='square';
                
            end
            
            % setta le opzioni dell'asse
            axis equal
            set(gca,'XGrid','on','YGrid','on')
            hold all
        end
        
        %%
        function N=drawN(n,p,U,res)
            % plotta le funzioni di base
            % n - numero di punti di controllo - 1
            % p - grado della curva
            % U - vettore dei nodi
            % res - risoluzione grafica
            
            % vettore parametrico
            t=0:1/(res-1):1;
            
            for z=1:length(t)
                i=bsl.findSpanKnot(t(z),n,U);
                N(z,:)=bsl.basicFunctionBspline(i,t(z),p,n,U);
            end
            
            plot(t',N)
            grid()
            
            xlabel('t curve [0, 1]')
            ylabel('Basic function, N')
        end
        
        %%
        function plotCloudPoint(Q,msize)
            % plotta nuvola di punti
            % msize - dimensione grafica del punto - marker grafico
            
            nc=size(Q,2);
            
            if nc==3
                plot3(Q(:,1),Q(:,2),Q(:,3))
                
                obj=get(gca,'Children'); % get current entity
                h=(obj(1));
                h.LineStyle='none';
                h.Marker='square';
                h.MarkerSize=msize;
                h.MarkerFaceColor='k';
            else
                plot(Q(:,1),Q(:,2),'ks')
                obj=get(gca,'Children'); % get current entity
                h=(obj(1));
                h.MarkerSize=msize;
                h.MarkerFaceColor='k';
            end
        end
        
    end
end
        

%trasformazione di rotazione rispetto a un asse
%CASO1: rot rispetto a un asse passante per l'origine
%moltiplico solo per R

%CASO2: se V non passa per l'origine terna0:globale
%K=kron(versV,versV'); %prodotto di Kronecker
%W=[0 -versV(3) versV(2)
  % versV(3) 0 -versV(1)
 %  -versV(2) versV(1) 0
%    ];
%I=eye(3,3);
%R=K+cos(a)*(I-K)+sin(a)*W; %Rodrigues
%a gradi
%Tf=T*R*Tinv;

%riflessione rispetto a un piano (P0,N)

%for i=1:length(Pco)
 %   d=(P0o-Pco(i,:))*No';
  %  rif=[2*d*No(1)
   %     2*d*No(2)
    %    2*d*No(3)];
   % T=I; 
   % T(:,4)=rif;
    %T(4,4)=1;
    %Pcro(i,:)=T*Pco(i,:)';
%end

%scala

%P1:origine locale, P0:origine globale
%caso1: P1=P0 
%S=[sx 0 0 0
%   0 sy 0 0
%   0 0 sz 0
%   0 0 0  1] uso solo questa
% Pcscala=S*Pco'

%caso2: P1 non è P0 
%S=[sx 0 0 0
%   0 sy 0 0
%   0 0 sz 0
%   0 0 0  1]
%T10=[eye(3,3) P1'
%     0 0 0 1] traslo l'origine globale nella locale
% Pcscala=T10*S*T01*Pco'

%previsione U: va da 0 a n-k+2, e ha n+k+1 elementi
%n-k+2=5-5+2=2
%n+k+1=5+5+1=11
%n=#Pc-1=5
%k=p+1=5
%U=[0,0,0,0,0,1,2,2,2,2,2]=[0,0,0,0,0,0.5,1,1,1,1,1]

%piano xy: ha equazione z=0 -> una normale è N=[0,0,1]
%se devo fare la riflessione rispetto a y=4:
%piano di equazione y=4 -> P0=[0 4 0] (punto del piano) 
%una normale a y=4 potrebbe essere (0,1,0)
