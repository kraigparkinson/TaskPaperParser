FasdUAS 1.101.10   ��   ��    k             l      ��  ��   ��
	This file contains functions that parse a TaskPaper document into AppleScript data objects that can be
	manipulated programmatically. It also contains methods for recreating the source document from the
	data objects.
	
	The parseTPDocument function takes a reference to a TaskPaper document and returns a script object with
	the following properties:
		projects: a simple list of strings. Each string is the contents of a project line.
		projectTasks: a list of lists of records that represent the individual tasks in the project. Every
					  sublist in this list contains the tasks of the project with the same index in the
					  projects property.
			The records that represent individual tasks have the following format:
			{ task: "- task text", tags: {"@tag1", "@tag2"}, notes:{"note 1", "note 2"} }
		orphanedTasks: a list of tasks that appear above the first project in the document.
					   Since they belong to no project they're "orphans".
					   This list has the same format as projectTasks.
		
		getProjectByIndex(i): function that returns a record with the following format:
							  { project: "Project:", tasks: {list of task records} }
							  The index is the index of the project in the projects list.
							  The projectTask item is retrieved by the same index.
		getDocument(): Rebuilds the taskpaper document from the data arrays and returns it as a string
	
	You can manipulate this data in any way you wish and then call getDocument to put it all
	back together.
     � 	 	� 
 	 T h i s   f i l e   c o n t a i n s   f u n c t i o n s   t h a t   p a r s e   a   T a s k P a p e r   d o c u m e n t   i n t o   A p p l e S c r i p t   d a t a   o b j e c t s   t h a t   c a n   b e 
 	 m a n i p u l a t e d   p r o g r a m m a t i c a l l y .   I t   a l s o   c o n t a i n s   m e t h o d s   f o r   r e c r e a t i n g   t h e   s o u r c e   d o c u m e n t   f r o m   t h e 
 	 d a t a   o b j e c t s . 
 	 
 	 T h e   p a r s e T P D o c u m e n t   f u n c t i o n   t a k e s   a   r e f e r e n c e   t o   a   T a s k P a p e r   d o c u m e n t   a n d   r e t u r n s   a   s c r i p t   o b j e c t   w i t h 
 	 t h e   f o l l o w i n g   p r o p e r t i e s : 
 	 	 p r o j e c t s :   a   s i m p l e   l i s t   o f   s t r i n g s .   E a c h   s t r i n g   i s   t h e   c o n t e n t s   o f   a   p r o j e c t   l i n e . 
 	 	 p r o j e c t T a s k s :   a   l i s t   o f   l i s t s   o f   r e c o r d s   t h a t   r e p r e s e n t   t h e   i n d i v i d u a l   t a s k s   i n   t h e   p r o j e c t .   E v e r y 
 	 	 	 	 	     s u b l i s t   i n   t h i s   l i s t   c o n t a i n s   t h e   t a s k s   o f   t h e   p r o j e c t   w i t h   t h e   s a m e   i n d e x   i n   t h e 
 	 	 	 	 	     p r o j e c t s   p r o p e r t y . 
 	 	 	 T h e   r e c o r d s   t h a t   r e p r e s e n t   i n d i v i d u a l   t a s k s   h a v e   t h e   f o l l o w i n g   f o r m a t : 
 	 	 	 {   t a s k :   " -   t a s k   t e x t " ,   t a g s :   { " @ t a g 1 " ,   " @ t a g 2 " } ,   n o t e s : { " n o t e   1 " ,   " n o t e   2 " }   } 
 	 	 o r p h a n e d T a s k s :   a   l i s t   o f   t a s k s   t h a t   a p p e a r   a b o v e   t h e   f i r s t   p r o j e c t   i n   t h e   d o c u m e n t . 
 	 	 	 	 	       S i n c e   t h e y   b e l o n g   t o   n o   p r o j e c t   t h e y ' r e   " o r p h a n s " . 
 	 	 	 	 	       T h i s   l i s t   h a s   t h e   s a m e   f o r m a t   a s   p r o j e c t T a s k s . 
 	 	 
 	 	 g e t P r o j e c t B y I n d e x ( i ) :   f u n c t i o n   t h a t   r e t u r n s   a   r e c o r d   w i t h   t h e   f o l l o w i n g   f o r m a t : 
 	 	 	 	 	 	 	     {   p r o j e c t :   " P r o j e c t : " ,   t a s k s :   { l i s t   o f   t a s k   r e c o r d s }   } 
 	 	 	 	 	 	 	     T h e   i n d e x   i s   t h e   i n d e x   o f   t h e   p r o j e c t   i n   t h e   p r o j e c t s   l i s t . 
 	 	 	 	 	 	 	     T h e   p r o j e c t T a s k   i t e m   i s   r e t r i e v e d   b y   t h e   s a m e   i n d e x . 
 	 	 g e t D o c u m e n t ( ) :   R e b u i l d s   t h e   t a s k p a p e r   d o c u m e n t   f r o m   t h e   d a t a   a r r a y s   a n d   r e t u r n s   i t   a s   a   s t r i n g 
 	 
 	 Y o u   c a n   m a n i p u l a t e   t h i s   d a t a   i n   a n y   w a y   y o u   w i s h   a n d   t h e n   c a l l   g e t D o c u m e n t   t o   p u t   i t   a l l 
 	 b a c k   t o g e t h e r . 
   
  
 l     ��������  ��  ��        i         I      �� ���� "0 parsetpdocument parseTPDocument   ��  o      ���� 0 tpdoc tpDoc��  ��    k    S       h     �� �� (0 tpdocumentelements TPDocumentElements  k             j     �� �� 0 projects    J     ����        j    �� �� 0 projecttasks projectTasks  J    ����        j    �� �� 0 orphanedtasks orphanedTasks  J    
����       !   l     ��������  ��  ��   !  " # " l     �� $ %��   $ I C Retrieve a project and its tasks by its index in the projects list    % � & & �   R e t r i e v e   a   p r o j e c t   a n d   i t s   t a s k s   b y   i t s   i n d e x   i n   t h e   p r o j e c t s   l i s t #  ' ( ' i     ) * ) I      �� +���� &0 getprojectbyindex getProjectByIndex +  ,�� , o      ���� 0 i  ��  ��   * L      - - K      . . �� / 0�� 0 project   / n    
 1 2 1 4    	�� 3
�� 
cobj 3 o    ���� 0 i   2 o    ���� 0 projects   0 �� 4���� 	0 tasks   4 n     5 6 5 4    �� 7
�� 
cobj 7 o    ���� 0 i   6 o    ���� 0 projecttasks projectTasks��   (  8 9 8 l     ��������  ��  ��   9  : ; : l     �� < =��   < , & Put humpdy dumpdy back together again    = � > > L   P u t   h u m p d y   d u m p d y   b a c k   t o g e t h e r   a g a i n ;  ?�� ? i     @ A @ I      �������� 0 getdocument getDocument��  ��   A k     � B B  C D C r      E F E m     ����  F o      ���� 0 i   D  G H G r     I J I m     K K � L L   J o      ���� 0 docstr docStr H  M N M l   ��������  ��  ��   N  O P O l   �� Q R��   Q    Append the orphaned tasks    R � S S 4   A p p e n d   t h e   o r p h a n e d   t a s k s P  T U T r     V W V m    	 X X � Y Y   W o      ���� 0 taskstr taskStr U  Z [ Z X    ] \�� ] \ k    X ^ ^  _ ` _ r    # a b a n   ! c d c o    !���� 0 task   d o    ���� 0 curtask curTask b o      ���� 0 taskstr taskStr `  e f e r   $ 5 g h g b   $ 3 i j i b   $ 1 k l k b   $ ' m n m o   $ %���� 0 taskstr taskStr n m   % & o o � p p    l n  ' 0 q r q I   ( 0�� s���� 0 implode   s  t u t m   ( ) v v � w w    u  x�� x n  ) , y z y o   * ,���� 0 tags   z o   ) *���� 0 curtask curTask��  ��   r  f   ' ( j m   1 2 { { � | |  
 h o      ���� 0 taskstr taskStr f  } ~ } Z   6 R  �����  l  6 < ����� � >  6 < � � � n  6 9 � � � o   7 9���� 	0 notes   � o   6 7���� 0 curtask curTask � J   9 ;����  ��  ��   � r   ? N � � � b   ? L � � � b   ? J � � � o   ? @���� 0 taskstr taskStr � n  @ I � � � I   A I�� ����� 0 implode   �  � � � m   A B � � � � �  
 �  ��� � n  B E � � � o   C E���� 	0 notes   � o   B C���� 0 curtask curTask��  ��   �  f   @ A � m   J K � � � � �  
 � o      ���� 0 taskstr taskStr��  ��   ~  � � � l  S S��������  ��  ��   �  ��� � r   S X � � � b   S V � � � o   S T���� 0 docstr docStr � o   T U���� 0 taskstr taskStr � o      ���� 0 docstr docStr��  �� 0 curtask curTask ] n    � � � o    ���� 0 orphanedtasks orphanedTasks �  f     [  � � � l  ^ ^��������  ��  ��   �  � � � W   ^ � � � � k   n � � �  � � � r   n v � � � n  n t � � � I   o t�� ����� &0 getprojectbyindex getProjectByIndex �  ��� � o   o p���� 0 i  ��  ��   �  f   n o � o      ���� 0 curproj curProj �  � � � l  w w��������  ��  ��   �  � � � r   w � � � � b   w � � � � b   w ~ � � � o   w x���� 0 docstr docStr � n  x } � � � o   y }���� 0 project   � o   x y���� 0 curproj curProj � m   ~ � � � � � �  
 � o      ���� 0 docstr docStr �  � � � r   � � � � � m   � � � � � � �   � o      ���� 0 taskstr taskStr �  � � � X   � � ��� � � k   � � � �  � � � r   � � � � � n  � � � � � o   � ����� 0 task   � o   � ����� 0 curtask curTask � o      ���� 0 taskstr taskStr �  � � � r   � � � � � b   � � � � � b   � � � � � b   � � � � � o   � ����� 0 taskstr taskStr � m   � � � � � � �    � n  � � � � � I   � ��� ����� 0 implode   �  � � � m   � � � � � � �    �  ��� � n  � � � � � o   � ����� 0 tags   � o   � ����� 0 curtask curTask��  ��   �  f   � � � m   � � � � � � �  
 � o      ���� 0 taskstr taskStr �  � � � Z   � � � ����� � l  � � ����� � >  � � � � � n  � � � � � o   � ����� 	0 notes   � o   � ����� 0 curtask curTask � J   � �����  ��  ��   � r   � � � � � b   � � � � � b   � � � � � o   � ����� 0 taskstr taskStr � n  � � � � � I   � ��� ����� 0 implode   �  � � � m   � � � � � � �  
 �  ��� � n  � � � � � o   � ����� 	0 notes   � o   � ����� 0 curtask curTask��  ��   �  f   � � � m   � �   �  
 � o      ���� 0 taskstr taskStr��  ��   �  l  � ���������  ��  ��   �� r   � � b   � � o   � ����� 0 docstr docStr o   � ��� 0 taskstr taskStr o      �~�~ 0 docstr docStr��  �� 0 curtask curTask � n  � �	
	 o   � ��}�} 	0 tasks  
 o   � ��|�| 0 curproj curProj �  l  � ��{�z�y�{  �z  �y   �x r   � � [   � � o   � ��w�w 0 i   m   � ��v�v  o      �u�u 0 i  �x   � =  b m o   b c�t�t 0 i   l  c l�s�r [   c l l  c j�q�p n   c j 1   f j�o
�o 
leng n  c f o   d f�n�n 0 projects    f   c d�q  �p   m   j k�m�m �s  �r   �  l  � ��l�k�j�l  �k  �j   �i L   � � o   � ��h�h 0 docstr docStr�i  ��     !  l   �g�f�e�g  �f  �e  ! "#" O   P$%$ k   O&& '(' r    )*) e    ++ n    ,-, 1    �d
�d 
TPrt- o    �c�c 0 tpdoc tpDoc* o      �b�b 0 doctext docText( ./. r    010 e    22 n    343 2    �a
�a 
cpar4 o    �`�` 0 doctext docText1 o      �_�_ 0 linelist lineList/ 565 l   �^�]�\�^  �]  �\  6 787 q    99 �[�Z�[ 0 
inprojects 
inProjects�Z  8 :;: r    <=< m    �Y
�Y boovfals= o      �X�X 0 
inprojects 
inProjects; >?> q    @@ �WA�W 0 taglist tagListA �V�U�V "0 projecttasklist projectTaskList�U  ? BCB r    3DED J    $FF GHG J     �T�T  H I�SI J     "�R�R  �S  E J      JJ KLK o      �Q�Q 0 taglist tagListL M�PM o      �O�O "0 projecttasklist projectTaskList�P  C NON q   4 4PP �N�M�N 0 
taskrecord 
taskRecord�M  O QRQ r   4 >STS K   4 <UU �LVW�L 0 task  V m   5 6XX �YY  W �KZ[�K 	0 notes  Z m   7 8\\ �]]  [ �J^�I�J 0 tags  ^ m   9 :__ �``  �I  T o      �H�H 0 
taskrecord 
taskRecordR aba q   ? ?cc �G�F�G 0 i  �F  b ded r   ? Bfgf m   ? @�E�E g o      �D�D 0 i  e hih X   C<j�Ckj k   S7ll mnm l  S S�Bop�B  o G A----- Handle orphaned tasks -------------------------------------   p �qq � - - - - -   H a n d l e   o r p h a n e d   t a s k s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -n rsr Z   S#tu�A�@t l  S Vv�?�>v =  S Vwxw o   S T�=�= 0 
inprojects 
inProjectsx m   T U�<
�< boovfals�?  �>  u Z   Yyz�;�:y l  Y c{�9�8{ n  Y c|}| I   Z c�7~�6�7 0 istask isTask~ �5 n   Z _��� 1   [ _�4
�4 
pcnt� o   Z [�3�3 0 curline curLine�5  �6  }  f   Y Z�9  �8  z k   f�� ��� l  f f�2���2  � "  Parse out tags in this task   � ��� 8   P a r s e   o u t   t a g s   i n   t h i s   t a s k� ��� r   f q��� n  f o��� I   g o�1��0�1 0 explode  � ��� m   g j�� ���   � ��/� o   j k�.�. 0 curline curLine�/  �0  �  f   f g� o      �-�- 0 taskbits taskBits� ��� r   r v��� J   r t�,�,  � o      �+�+ 0 taglist tagList� ��� r   w {��� J   w y�*�*  � o      �)�) 0 tasklist taskList� ��� X   | ���(�� Z   � ����'�� l  � ���&�%� C  � ���� o   � ��$�$ 0 curbit curBit� m   � ��� ���  @�&  �%  � r   � ���� n   � ���� 1   � ��#
�# 
pcnt� o   � ��"�" 0 curbit curBit� n      ���  ;   � �� o   � ��!�! 0 taglist tagList�'  � r   � ���� n   � ���� 1   � �� 
�  
pcnt� o   � ��� 0 curbit curBit� n      ���  ;   � �� o   � ��� 0 tasklist taskList�( 0 curbit curBit� o    ��� 0 taskbits taskBits� ��� l  � �����  �  �  � ��� l  � �����  �   Look for notes   � ���    L o o k   f o r   n o t e s� ��� Q   � ����� k   � ��� ��� r   � ���� [   � ���� o   � ��� 0 i  � m   � ��� � o      �� 0 j  � ��� r   � ���� J   � ���  � o      �� 0 notelist noteList� ��� V   � ���� k   � ��� ��� r   � ���� n   � ���� 4   � ���
� 
cobj� o   � ��� 0 j  � o   � ��� 0 linelist lineList� n      ���  ;   � �� o   � ��� 0 notelist noteList� ��� r   � ���� [   � ���� o   � ��� 0 j  � m   � ��� � o      �
�
 0 j  �  � l  � ���	�� F   � ���� l  � ����� =  � ���� n  � ���� I   � ����� 0 istask isTask� ��� n   � ���� 4   � ���
� 
cobj� o   � ��� 0 j  � o   � �� �  0 linelist lineList�  �  �  f   � �� m   � ���
�� boovfals�  �  � l  � ������� =  � ���� n  � ���� I   � �������� 0 	isproject 	isProject� ���� n   � ���� 4   � ����
�� 
cobj� o   � ����� 0 j  � o   � ����� 0 linelist lineList��  ��  �  f   � �� m   � ���
�� boovfals��  ��  �	  �  �  � R      ������
�� .ascrerr ****      � ****��  ��  �  � ��� l  � �������  � � � The next iterations of the master loop will hit the notes, but they will be silently ignored by it because they don't match any of the conditions   � ���$   T h e   n e x t   i t e r a t i o n s   o f   t h e   m a s t e r   l o o p   w i l l   h i t   t h e   n o t e s ,   b u t   t h e y   w i l l   b e   s i l e n t l y   i g n o r e d   b y   i t   b e c a u s e   t h e y   d o n ' t   m a t c h   a n y   o f   t h e   c o n d i t i o n s� ��� l  � ���������  ��  ��  � ��� l  � �������  � 5 / Set up task record and commit it to the object   � ��� ^   S e t   u p   t a s k   r e c o r d   a n d   c o m m i t   i t   t o   t h e   o b j e c t� � � r   � n  � I   ������� 0 implode    m   � � �		    
��
 o   � ����� 0 tasklist taskList��  ��    f   � � n      o  ���� 0 task   o  ���� 0 
taskrecord 
taskRecord   s   o  ���� 0 notelist noteList n      o  	���� 	0 notes   o  	���� 0 
taskrecord 
taskRecord  s   o  ���� 0 taglist tagList n      o  ���� 0 tags   o  ���� 0 
taskrecord 
taskRecord  l ��������  ��  ��   �� s   o  ���� 0 
taskrecord 
taskRecord l     ���� n         ;    n !"! o  ���� 0 orphanedtasks orphanedTasks" o  ���� (0 tpdocumentelements TPDocumentElements��  ��  ��  �;  �:  �A  �@  s #$# l $$��%&��  % E ?----- Handle projects -----------------------------------------   & �'' ~ - - - - -   H a n d l e   p r o j e c t s   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -$ ()( Z  $n*+����* l $A,����, F  $A-.- = $0/0/ n $.121 I  %.��3���� 0 istask isTask3 4��4 n  %*565 1  &*��
�� 
pcnt6 o  %&���� 0 curline curLine��  ��  2  f  $%0 m  ./��
�� boovfals. n 3=787 I  4=��9���� 0 	isproject 	isProject9 :��: n  49;<; 1  59��
�� 
pcnt< o  45���� 0 curline curLine��  ��  8  f  34��  ��  + k  Dj== >?> r  DP@A@ n  DIBCB 1  EI��
�� 
pcntC o  DE���� 0 curline curLineA n      DED  ;  NOE n INFGF o  JN���� 0 projects  G o  IJ���� (0 tpdocumentelements TPDocumentElements? HIH l QQ��������  ��  ��  I JKJ l QQ��LM��  L . ( Commit previous project's tasks, if any   M �NN P   C o m m i t   p r e v i o u s   p r o j e c t ' s   t a s k s ,   i f   a n yK OPO Z  QeQR��SQ l QTT����T = QTUVU o  QR���� 0 
inprojects 
inProjectsV m  RS��
�� boovtrue��  ��  R s  W_WXW o  WX���� "0 projecttasklist projectTaskListX l     Y����Y n      Z[Z  ;  ]^[ n X]\]\ o  Y]���� 0 projecttasks projectTasks] o  XY���� (0 tpdocumentelements TPDocumentElements��  ��  ��  S r  be^_^ m  bc��
�� boovtrue_ o      ���� 0 
inprojects 
inProjectsP `��` r  fjaba J  fh����  b o      ���� "0 projecttasklist projectTaskList��  ��  ��  ) cdc l oo��ef��  e L F----- Handle tasks in a project --------------------------------------   f �gg � - - - - -   H a n d l e   t a s k s   i n   a   p r o j e c t   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -d hih Z  o1jk����j l oyl����l n oymnm I  py��o���� 0 istask isTasko p��p n  puqrq 1  qu��
�� 
pcntr o  pq���� 0 curline curLine��  ��  n  f  op��  ��  k k  |-ss tut l ||��vw��  v "  Parse out tags in this task   w �xx 8   P a r s e   o u t   t a g s   i n   t h i s   t a s ku yzy r  |�{|{ n |�}~} I  }������� 0 explode   ��� m  }��� ���   � ���� o  ������ 0 curline curLine��  ��  ~  f  |}| o      ���� 0 taskbits taskBitsz ��� r  ����� J  ������  � o      ���� 0 taglist tagList� ��� r  ����� J  ������  � o      ���� 0 tasklist taskList� ��� X  ������� Z  �������� l �������� C ����� o  ������ 0 curbit curBit� m  ���� ���  @��  ��  � r  ����� n  ����� 1  ����
�� 
pcnt� o  ������ 0 curbit curBit� n      ���  ;  ��� o  ������ 0 taglist tagList��  � r  ����� n  ����� 1  ����
�� 
pcnt� o  ������ 0 curbit curBit� n      ���  ;  ��� o  ������ 0 tasklist taskList�� 0 curbit curBit� o  ������ 0 taskbits taskBits� ��� l ����������  ��  ��  � ��� l ��������  �   Look for notes   � ���    L o o k   f o r   n o t e s� ��� Q  ������ k  ��� ��� r  ����� [  ����� o  ������ 0 i  � m  ������ � o      ���� 0 j  � ��� r  ����� J  ������  � o      ���� 0 notelist noteList� ���� V  ���� k  � �� ��� r  ����� n  ����� 4  �����
�� 
cobj� o  ������ 0 j  � o  ������ 0 linelist lineList� n      ���  ;  ��� o  ������ 0 notelist noteList� ���� r  � ��� [  ����� o  ������ 0 j  � m  ������ � o      �� 0 j  ��  � l ����~�}� F  ����� l ����|�{� = ����� n ����� I  ���z��y�z 0 istask isTask� ��x� n  ����� 4  ���w�
�w 
cobj� o  ���v�v 0 j  � o  ���u�u 0 linelist lineList�x  �y  �  f  ��� m  ���t
�t boovfals�|  �{  � l ����s�r� = ����� n ����� I  ���q��p�q 0 	isproject 	isProject� ��o� n  ����� 4  ���n�
�n 
cobj� o  ���m�m 0 j  � o  ���l�l 0 linelist lineList�o  �p  �  f  ��� m  ���k
�k boovfals�s  �r  �~  �}  ��  � R      �j�i�h
�j .ascrerr ****      � ****�i  �h  ��  � ��� l �g���g  � � � The next iterations of the master loop will hit the notes, but they will be silently ignored by it because they don't match any of the conditions   � ���$   T h e   n e x t   i t e r a t i o n s   o f   t h e   m a s t e r   l o o p   w i l l   h i t   t h e   n o t e s ,   b u t   t h e y   w i l l   b e   s i l e n t l y   i g n o r e d   b y   i t   b e c a u s e   t h e y   d o n ' t   m a t c h   a n y   o f   t h e   c o n d i t i o n s� ��� l �f�e�d�f  �e  �d  � ��� l �c���c  � = 7 Set up task record and add it to the project task list   � ��� n   S e t   u p   t a s k   r e c o r d   a n d   a d d   i t   t o   t h e   p r o j e c t   t a s k   l i s t� ��� r  ��� n ��� I  �b��a�b 0 implode  � ��� m  �� ���   � ��`� o  �_�_ 0 tasklist taskList�`  �a  �  f  � n     ��� o  �^�^ 0 task  � o  �]�] 0 
taskrecord 
taskRecord� ��� s  "   o  �\�\ 0 notelist noteList n      o  !�[�[ 	0 notes   o  �Z�Z 0 
taskrecord 
taskRecord�  s  #( o  #$�Y�Y 0 taglist tagList n     	 o  %'�X�X 0 tags  	 o  $%�W�W 0 
taskrecord 
taskRecord 

 l ))�V�U�T�V  �U  �T   �S s  )- o  )*�R�R 0 
taskrecord 
taskRecord l     �Q�P n        ;  +, o  *+�O�O "0 projecttasklist projectTaskList�Q  �P  �S  ��  ��  i  l 22�N�M�L�N  �M  �L   �K r  27 [  25 o  23�J�J 0 i   m  34�I�I  o      �H�H 0 i  �K  �C 0 curline curLinek o   F G�G�G 0 linelist lineListi  l ==�F�E�D�F  �E  �D    l ==�C�C   % Commit the last project's tasks    � > C o m m i t   t h e   l a s t   p r o j e c t ' s   t a s k s  �B  Z  =O!"�A�@! l =@#�?�># = =@$%$ o  =>�=�= 0 
inprojects 
inProjects% m  >?�<
�< boovtrue�?  �>  " s  CK&'& o  CD�;�; "0 projecttasklist projectTaskList' l     (�:�9( n      )*)  ;  IJ* n DI+,+ o  EI�8�8 0 projecttasks projectTasks, o  DE�7�7 (0 tpdocumentelements TPDocumentElements�:  �9  �A  �@  �B  % m    	--�                                                                                  TkPr   alis    X  Macintosh HD               ��YhH+   ;�TaskPaper.app                                                   %-�^�}        ����  	                Applications    �ڭ�      �^��     ;�  'Macintosh HD:Applications:TaskPaper.app     T a s k P a p e r . a p p    M a c i n t o s h   H D  Applications/TaskPaper.app  / ��  # ./. l QQ�6�5�4�6  �5  �4  / 0�30 L  QS11 o  QR�2�2 (0 tpdocumentelements TPDocumentElements�3    232 l     �1�0�/�1  �0  �/  3 454 i    676 I      �.8�-�. 0 explode  8 9:9 o      �,�, 	0 delim  : ;�+; o      �*�* 0 str  �+  �-  7 k     << =>= r     ?@? n    ABA 1    �)
�) 
txdlB 1     �(
�( 
ascr@ o      �'�' 0 	olddelims 	oldDelims> CDC r    EFE J    	GG H�&H o    �%�% 	0 delim  �&  F n     IJI 1   
 �$
�$ 
txdlJ 1   	 
�#
�# 
ascrD KLK r    MNM e    OO n    PQP 2   �"
�" 
citmQ o    �!�! 0 str  N o      � �  
0 peices  L RSR r    TUT o    �� 0 	olddelims 	oldDelimsU n     VWV 1    �
� 
txdlW 1    �
� 
ascrS XYX l   ����  �  �  Y Z�Z L    [[ o    �� 
0 peices  �  5 \]\ l     ����  �  �  ] ^_^ i    `a` I      �b�� 0 implode  b cdc o      �� 	0 delim  d e�e o      �� 
0 pieces  �  �  a k     ff ghg r     iji n    klk 1    �
� 
txdll 1     �
� 
ascrj o      �� 0 	olddelims 	oldDelimsh mnm r    opo J    	qq r�r o    �� 	0 delim  �  p n     sts 1   
 �

�
 
txdlt 1   	 
�	
�	 
ascrn uvu r    wxw c    yzy o    �� 
0 pieces  z m    �
� 
TEXTx o      �� 0 str  v {|{ r    }~} o    �� 0 	olddelims 	oldDelims~ n     � 1    �
� 
txdl� 1    �
� 
ascr| ��� l   ��� �  �  �   � ���� L    �� o    ���� 0 str  ��  _ ��� l     ��������  ��  ��  � ��� i    ��� I      ������� 0 istask isTask� ���� o      ���� 0 str  ��  ��  � k     c�� ��� r     ��� e     �� n     ��� 2   ��
�� 
cha � o     ���� 0 str  � o      ���� 0 strlist strList� ��� l   ��������  ��  ��  � ��� r    
��� m    ���� � o      ���� 0 i  � ��� X    `����� k    [�� ��� Z    U������ l   4������ F    4��� F    *��� l    ������ >    ��� n    ��� 1    ��
�� 
pcnt� o    ���� 0 curchar curChar� m    �� ���  -��  ��  � l  # (������ >  # (��� n   # &��� 1   $ &��
�� 
pcnt� o   # $���� 0 curchar curChar� m   & '�� ���   ��  ��  � l  - 2������ >  - 2��� n   - 0��� 1   . 0��
�� 
pcnt� o   - .���� 0 curchar curChar� m   0 1�� ���  	��  ��  ��  ��  � L   7 9�� m   7 8��
�� boovfals� ��� l  < L������ F   < L��� l  < A������ =  < A��� n   < ?��� 1   = ?��
�� 
pcnt� o   < =���� 0 curchar curChar� m   ? @�� ���  -��  ��  � l  D J������ =  D J��� n   D H��� 4   E H���
�� 
cobj� o   F G���� 0 i  � o   D E���� 0 strlist strList� m   H I�� ���   ��  ��  ��  ��  � ���� L   O Q�� m   O P��
�� boovtrue��  ��  � ��� l  V V��������  ��  ��  � ���� r   V [��� [   V Y��� o   V W���� 0 i  � m   W X���� � o      ���� 0 i  ��  �� 0 curchar curChar� o    ���� 0 strlist strList� ��� l  a a��������  ��  ��  � ���� L   a c�� m   a b��
�� boovfals��  � ��� l     ��������  ��  ��  � ���� i    ��� I      ������� 0 	isproject 	isProject� ���� o      ���� 0 str  ��  ��  � P     
����� L    	�� D    ��� o    ���� 0 str  � m    �� ���  :��  � ����
�� conswhit��  ��       ����������  � ������������ "0 parsetpdocument parseTPDocument�� 0 explode  �� 0 implode  �� 0 istask isTask�� 0 	isproject 	isProject� �� ���������� "0 parsetpdocument parseTPDocument�� ����� �  ���� 0 tpdoc tpDoc��  � �������������������������������� 0 tpdoc tpDoc�� (0 tpdocumentelements TPDocumentElements�� 0 doctext docText�� 0 linelist lineList�� 0 
inprojects 
inProjects�� 0 taglist tagList�� "0 projecttasklist projectTaskList�� 0 
taskrecord 
taskRecord�� 0 i  �� 0 curline curLine�� 0 taskbits taskBits�� 0 tasklist taskList�� 0 curbit curBit�� 0 j  �� 0 notelist noteList� !�� �-��������X��\��_����������������������������������� (0 tpdocumentelements TPDocumentElements� �����������
�� .ascrinit****      � ****� k     ��  ��  ��  ��  '    ?����  ��  ��  � ��������~�� 0 projects  �� 0 projecttasks projectTasks�� 0 orphanedtasks orphanedTasks� &0 getprojectbyindex getProjectByIndex�~ 0 getdocument getDocument� �}�|�{�} 0 projects  �| 0 projecttasks projectTasks�{ 0 orphanedtasks orphanedTasks �z *�y�x�w�z &0 getprojectbyindex getProjectByIndex�y �v�v   �u�u 0 i  �x   �t�t 0 i   �s�r�q�p�s 0 project  
�r 
cobj�q 	0 tasks  �p �w �b   �/E�b  �/E� �o A�n�m�l�o 0 getdocument getDocument�n  �m   �k�j�i�h�g�k 0 i  �j 0 docstr docStr�i 0 taskstr taskStr�h 0 curtask curTask�g 0 curproj curProj  K X�f�e�d�c�b o v�a�` {�_ � ��^�]�\�[ � ��Z � � � � �f 0 orphanedtasks orphanedTasks
�e 
kocl
�d 
cobj
�c .corecnte****       ****�b 0 task  �a 0 tags  �` 0 implode  �_ 	0 notes  �^ 0 projects  
�] 
leng�\ &0 getprojectbyindex getProjectByIndex�[ 0 project  �Z 	0 tasks  �l �kE�O�E�O�E�O P)�,[��l kh ��,E�O��%)��,l+ 
%�%E�O��,jv �)���,l+ 
%�%E�Y hO��%E�[OY��O �h�)�,a ,k )�k+ E�O��a ,%a %E�Oa E�O \�a ,[��l kh ��,E�O�a %)a ��,l+ 
%a %E�O��,jv �)a ��,l+ 
%a %E�Y hO��%E�[OY��O�kE�[OY�qO��� jv�Ojv�Ojv�OL OL 
�� 
TPrt
�� 
cpar
�� 
cobj�� 0 task  �� 	0 notes  �� 0 tags  �� 
�� 
kocl
�� .corecnte****       ****
�� 
pcnt�� 0 istask isTask�� 0 explode  �� 0 	isproject 	isProject
�� 
bool��  ��  �� 0 implode  �� 0 orphanedtasks orphanedTasks�� 0 projects  �� 0 projecttasks projectTasks��T��K S�O�E��,EE�O��-EE�OfE�OjvjvlvE[�k/E�Z[�l/E�ZO�������E�OkE�O��[��l kh 	�f  �)�a ,k+  �)a �l+ E�OjvE�OjvE�O /�[��l kh �a  �a ,�6FY 
�a ,�6F[OY��O D�kE�OjvE�O 3h)��/k+ f 	 )��/k+ f a &��/�6FO�kE�[OY��W X  hO)a �l+ ��,FO���,GO���,GO��a ,6GY hY hO)�a ,k+ f 	 )�a ,k+ a & +�a ,�a ,6FO�e  ��a ,6GY eE�OjvE�Y hO)�a ,k+  �)a �l+ E�OjvE�OjvE�O /�[��l kh �a  �a ,�6FY 
�a ,�6F[OY��O D�kE�OjvE�O 3h)��/k+ f 	 )��/k+ f a &��/�6FO�kE�[OY��W X  hO)a  �l+ ��,FO���,GO���,GO��6GY hO�kE�[OY�O�e  ��a ,6GY hUO�� �Y7�X�W	�V�Y 0 explode  �X �U
�U 
  �T�S�T 	0 delim  �S 0 str  �W   �R�Q�P�O�R 	0 delim  �Q 0 str  �P 0 	olddelims 	oldDelims�O 
0 peices  	 �N�M�L
�N 
ascr
�M 
txdl
�L 
citm�V ��,E�O�kv��,FO��-EE�O���,FO�� �Ka�J�I�H�K 0 implode  �J �G�G   �F�E�F 	0 delim  �E 
0 pieces  �I   �D�C�B�A�D 	0 delim  �C 
0 pieces  �B 0 	olddelims 	oldDelims�A 0 str   �@�?�>
�@ 
ascr
�? 
txdl
�> 
TEXT�H ��,E�O�kv��,FO��&E�O���,FO�� �=��<�;�:�= 0 istask isTask�< �9�9   �8�8 0 str  �;   �7�6�5�4�7 0 str  �6 0 strlist strList�5 0 i  �4 0 curchar curChar �3�2�1�0�/���.���
�3 
cha 
�2 
kocl
�1 
cobj
�0 .corecnte****       ****
�/ 
pcnt
�. 
bool�: d��-EE�OlE�O T�[��l kh ��,�	 	��,��&	 	��,��& fY ��,� 	 
��/� �& eY hO�kE�[OY��Of� �-��,�+�*�- 0 	isproject 	isProject�, �)�)   �(�( 0 str  �+   �'�' 0 str   ���* g� ��V ascr  ��ޭ