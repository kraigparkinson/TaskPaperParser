FasdUAS 1.101.10   ��   ��    k             l      ��  ��   OI
	*** NOTE TO TIGER USERS ***
	This script will not work if run from Tiger's script editor. This is because it uses "path to me" to locate itself and load the parser library, and there is a bug in Tiger's script editor that causes "path to me" to work improperly when a script is run from the script editor.
	
	To work around this bug, either run the script from the scripts menu, or hard-code the path to the script.
	Leopard users are not affected by this issue.
	-------------------
	
	This is an example using the TaskPaper document parser. it turns this:
	Project A:
	- This is a task @home
	- This is another task @work
	Project B:
	- This is a third task @work
	- This is a fourth task @home
	
	...into this:
	home:
	- This is a task [Project A] 
	- This is a fourth task [Project B] 
	work:
	- This is another task [Project A] 
	- This is a third task [Project B] 
	Project A:
	Project B:
	
	This behavior was a feature request in the TaskPaper forums. The script accomplishes this by looping through the parsed TP document object structure and modifying it as it goes. Note that modifying a list while looping through it has complications that require careful programming to avoid.
	
	To apply this script for practical use, you'll need to change the global variable tagList to be a list of the context tags you'd like the script to look for.

     � 	 	
� 
 	 * * *   N O T E   T O   T I G E R   U S E R S   * * * 
 	 T h i s   s c r i p t   w i l l   n o t   w o r k   i f   r u n   f r o m   T i g e r ' s   s c r i p t   e d i t o r .   T h i s   i s   b e c a u s e   i t   u s e s   " p a t h   t o   m e "   t o   l o c a t e   i t s e l f   a n d   l o a d   t h e   p a r s e r   l i b r a r y ,   a n d   t h e r e   i s   a   b u g   i n   T i g e r ' s   s c r i p t   e d i t o r   t h a t   c a u s e s   " p a t h   t o   m e "   t o   w o r k   i m p r o p e r l y   w h e n   a   s c r i p t   i s   r u n   f r o m   t h e   s c r i p t   e d i t o r . 
 	 
 	 T o   w o r k   a r o u n d   t h i s   b u g ,   e i t h e r   r u n   t h e   s c r i p t   f r o m   t h e   s c r i p t s   m e n u ,   o r   h a r d - c o d e   t h e   p a t h   t o   t h e   s c r i p t . 
 	 L e o p a r d   u s e r s   a r e   n o t   a f f e c t e d   b y   t h i s   i s s u e . 
 	 - - - - - - - - - - - - - - - - - - - 
 	 
 	 T h i s   i s   a n   e x a m p l e   u s i n g   t h e   T a s k P a p e r   d o c u m e n t   p a r s e r .   i t   t u r n s   t h i s : 
 	 P r o j e c t   A : 
 	 -   T h i s   i s   a   t a s k   @ h o m e 
 	 -   T h i s   i s   a n o t h e r   t a s k   @ w o r k 
 	 P r o j e c t   B : 
 	 -   T h i s   i s   a   t h i r d   t a s k   @ w o r k 
 	 -   T h i s   i s   a   f o u r t h   t a s k   @ h o m e 
 	 
 	 . . . i n t o   t h i s : 
 	 h o m e : 
 	 -   T h i s   i s   a   t a s k   [ P r o j e c t   A ]   
 	 -   T h i s   i s   a   f o u r t h   t a s k   [ P r o j e c t   B ]   
 	 w o r k : 
 	 -   T h i s   i s   a n o t h e r   t a s k   [ P r o j e c t   A ]   
 	 -   T h i s   i s   a   t h i r d   t a s k   [ P r o j e c t   B ]   
 	 P r o j e c t   A : 
 	 P r o j e c t   B : 
 	 
 	 T h i s   b e h a v i o r   w a s   a   f e a t u r e   r e q u e s t   i n   t h e   T a s k P a p e r   f o r u m s .   T h e   s c r i p t   a c c o m p l i s h e s   t h i s   b y   l o o p i n g   t h r o u g h   t h e   p a r s e d   T P   d o c u m e n t   o b j e c t   s t r u c t u r e   a n d   m o d i f y i n g   i t   a s   i t   g o e s .   N o t e   t h a t   m o d i f y i n g   a   l i s t   w h i l e   l o o p i n g   t h r o u g h   i t   h a s   c o m p l i c a t i o n s   t h a t   r e q u i r e   c a r e f u l   p r o g r a m m i n g   t o   a v o i d . 
 	 
 	 T o   a p p l y   t h i s   s c r i p t   f o r   p r a c t i c a l   u s e ,   y o u ' l l   n e e d   t o   c h a n g e   t h e   g l o b a l   v a r i a b l e   t a g L i s t   t o   b e   a   l i s t   o f   t h e   c o n t e x t   t a g s   y o u ' d   l i k e   t h e   s c r i p t   t o   l o o k   f o r . 
 
   
  
 l     ��  ��    1 + Load the munger for TP document processing     �   V   L o a d   t h e   m u n g e r   f o r   T P   d o c u m e n t   p r o c e s s i n g      p         ������ 
0 munger  ��        l    ) ����  Q     )     r        I   �� ��
�� .sysoloadscpt        file  4    �� 
�� 
file  l    ����  b        l    ����  c       !   l   
 "���� " I   
�� #��
�� .earsffdralis        afdr #  f    ��  ��  ��   ! m   
 ��
�� 
TEXT��  ��    m     $ $ � % % ` C o n t e n t s : R e s o u r c e s : S c r i p t s : T a s k P a p e r   M u n g e r . s c p t��  ��  ��    o      ���� 
0 munger    R      ������
�� .ascrerr ****      � ****��  ��    k    ) & &  ' ( ' I   &�� ) *
�� .sysodlogaskr        TEXT ) m     + + � , , Z C o u l d   n o t   l o a d   t h e   d o c u m e n t   p r o c e s s o r   s c r i p t ! * �� -��
�� 
btns - J    " . .  /�� / m      0 0 � 1 1 
 D ' o h !��  ��   (  2�� 2 L   ' )����  ��  ��  ��     3 4 3 l     ��������  ��  ��   4  5 6 5 p       7 7 ������ 0 taglist tagList��   6  8 9 8 l     �� : ;��   : 8 2 Set this to your preferred list of tags to filter    ; � < < d   S e t   t h i s   t o   y o u r   p r e f e r r e d   l i s t   o f   t a g s   t o   f i l t e r 9  = > = l     �� ? @��   ? D > Note that you must omit the '@'; this is for your convenience    @ � A A |   N o t e   t h a t   y o u   m u s t   o m i t   t h e   ' @ ' ;   t h i s   i s   f o r   y o u r   c o n v e n i e n c e >  B C B l  * 0 D���� D r   * 0 E F E J   * . G G  H I H m   * + J J � K K  w o r k I  L�� L m   + , M M � N N  h o m e��   F o      ���� 0 taglist tagList��  ��   C  O P O l     ��������  ��  ��   P  Q R Q l     �� S T��   S + % Get and parse the TaskPaper Document    T � U U J   G e t   a n d   p a r s e   t h e   T a s k P a p e r   D o c u m e n t R  V W V l  1 E X���� X O  1 E Y Z Y r   5 D [ \ [ l  5 @ ]���� ] n   5 @ ^ _ ^ 1   < @��
�� 
pcnt _ l  5 < `���� ` e   5 < a a 4  5 <�� b
�� 
docu b m   9 :���� ��  ��  ��  ��   \ o      ���� 0 tpdoc tpDoc Z m   1 2 c c�                                                                                  TkPr   alis    X  Macintosh HD               ��YhH+   ;�TaskPaper.app                                                   %-�^�}        ����  	                Applications    �ڭ�      �^��     ;�  'Macintosh HD:Applications:TaskPaper.app     T a s k P a p e r . a p p    M a c i n t o s h   H D  Applications/TaskPaper.app  / ��  ��  ��   W  d e d l  F R f���� f r   F R g h g l  F N i���� i n  F N j k j I   G N�� l���� "0 parsetpdocument parseTPDocument l  m�� m o   G J���� 0 tpdoc tpDoc��  ��   k o   F G���� 
0 munger  ��  ��   h o      ���� 0 	parseddoc 	parsedDoc��  ��   e  n o n l     ��������  ��  ��   o  p q p l     �� r s��   r 5 / Rejigger the document to fit our evil purposes    s � t t ^   R e j i g g e r   t h e   d o c u m e n t   t o   f i t   o u r   e v i l   p u r p o s e s q  u v u l     �� w x��   w � � I'm using an unusual style of loop termination because I'm modifying the list as I go, and this breaks ordinary repeat with...in loops.    x � y y   I ' m   u s i n g   a n   u n u s u a l   s t y l e   o f   l o o p   t e r m i n a t i o n   b e c a u s e   I ' m   m o d i f y i n g   t h e   l i s t   a s   I   g o ,   a n d   t h i s   b r e a k s   o r d i n a r y   r e p e a t   w i t h . . . i n   l o o p s . v  z { z l  S Y |���� | r   S Y } ~ } J   S U����   ~ o      ���� "0 workingtasklist workingTaskList��  ��   {   �  l  Z ����� � X   Z ��� � � k   n � �  � � � l  n n��������  ��  ��   �  � � � l  n n�� � ���   � t n Here we run through all the tasks in the document, searching for tasks that have a tag (searchTag) in tagList    � � � � �   H e r e   w e   r u n   t h r o u g h   a l l   t h e   t a s k s   i n   t h e   d o c u m e n t ,   s e a r c h i n g   f o r   t a s k s   t h a t   h a v e   a   t a g   ( s e a r c h T a g )   i n   t a g L i s t �  � � � l  n n�� � ���   � } w If we find one, we remove it from its former project, remove the found tag, and add a tag of the former project's name    � � � � �   I f   w e   f i n d   o n e ,   w e   r e m o v e   i t   f r o m   i t s   f o r m e r   p r o j e c t ,   r e m o v e   t h e   f o u n d   t a g ,   a n d   a d d   a   t a g   o f   t h e   f o r m e r   p r o j e c t ' s   n a m e �  � � � r   n s � � � m   n o����  � o      ���� 0 	projindex 	projIndex �  � � � T   t� � � k   y� � �  � � � Z   y � � ��� � � l  y � ����� � B   y � � � � o   y |���� 0 	projindex 	projIndex � l  | � ����� � n   | � � � � 1   � ���
�� 
leng � n  | � � � � o    ����� 0 projecttasks projectTasks � o   | ���� 0 	parseddoc 	parsedDoc��  ��  ��  ��   � r   � � � � � l  � � ����� � N   � � � � n   � � � � � 4   � ��� �
�� 
cobj � o   � ����� 0 	projindex 	projIndex � n  � � � � � o   � ����� 0 projecttasks projectTasks � o   � ����� 0 	parseddoc 	parsedDoc��  ��   � o      ���� 0 curtasklist curTaskList��   �  S   � � �  � � � l  � ���������  ��  ��   �  � � � r   � � � � � m   � �����  � o      ���� 0 	taskindex 	taskIndex �  � � � T   �� � � k   �� � �  � � � Z   � � � ��� � � l  � � ����� � B   � � � � � o   � ����� 0 	taskindex 	taskIndex � l  � � ����� � n   � � � � � 1   � ���
�� 
leng � o   � ����� 0 curtasklist curTaskList��  ��  ��  ��   � r   � � � � � l  � � ����� � N   � � � � n   � � � � � 4   � ��� �
�� 
cobj � o   � ����� 0 	taskindex 	taskIndex � o   � ����� 0 curtasklist curTaskList��  ��   � o      ���� 0 curtask curTask��   �  S   � � �  � � � l  � ���������  ��  ��   �  � � � r   � � � � � m   � ���
�� boovfals � o      ����  0 foundtagintask foundTagInTask �  � � � r   � � � � � m   � �����  � o      ���� 0 tagindex tagIndex �  � � � T   �� � � k   �� � �  � � � Z   �
 � ��� � � l  � � ����� � B   � � � � � o   � ��� 0 tagindex tagIndex � l  � � ��~�} � n   � � � � � 1   � ��|
�| 
leng � n  � � � � � o   � ��{�{ 0 tags   � o   � ��z�z 0 curtask curTask�~  �}  ��  ��   � r   � � � � l  � ��y�x � N   � � � n   � � � � 4   ��w �
�w 
cobj � o   � �v�v 0 tagindex tagIndex � n  � � � � � o   � ��u�u 0 tags   � o   � ��t�t 0 curtask curTask�y  �x   � o      �s�s 0 curtag curTag��   �  S  	
 �  � � � l �r�q�p�r  �q  �p   �  � � � Z  � � ��o�n � l  ��m�l � =  � � � l  ��k�j � b   � � � m   � � � � �  @ � o  �i�i 0 	searchtag 	searchTag�k  �j   � l  ��h�g � n   � � � 1  �f
�f 
pcnt � o  �e�e 0 curtag curTag�h  �g  �m  �l   � k  �    r    m  �d
�d boovtrue o      �c�c  0 foundtagintask foundTagInTask  l !!�b�a�`�b  �a  �`    r  !8	
	 I  !0�_�^�_ ,0 removereferenceditem removeReferencedItem  o  "%�]�] 0 curtag curTag �\ n %, o  (,�[�[ 0 tags   o  %(�Z�Z 0 curtask curTask�\  �^  
 n      o  37�Y�Y 0 tags   o  03�X�X 0 curtask curTask  l 99�W�W   A ; Chop the : off the end of the project, for cosmetics' sake    � v   C h o p   t h e   :   o f f   t h e   e n d   o f   t h e   p r o j e c t ,   f o r   c o s m e t i c s '   s a k e  r  9q b  9i n 9@ o  <@�V�V 0 task   o  9<�U�U 0 curtask curTask l @h �T�S  b  @h!"! l @d#�R�Q# c  @d$%$ b  @b&'& m  @C(( �))    [' l Ca*�P�O* n  Ca+,+ 1  ]a�N
�N 
rvse, n  C]-.- 1  Y]�M
�M 
rest. n  CY/0/ 1  UY�L
�L 
rvse0 n  CU121 2  QU�K
�K 
cha 2 l CQ3�J�I3 n  CQ454 4  JQ�H6
�H 
cobj6 o  MP�G�G 0 	projindex 	projIndex5 n CJ787 o  FJ�F�F 0 projects  8 o  CF�E�E 0 	parseddoc 	parsedDoc�J  �I  �P  �O  % m  bc�D
�D 
TEXT�R  �Q  " m  dg99 �::  ]�T  �S   n     ;<; o  lp�C�C 0 task  < o  il�B�B 0 curtask curTask =>= s  r~?@? l ryA�A�@A n  ryBCB 1  uy�?
�? 
pcntC o  ru�>�> 0 curtask curTask�A  �@  @ l     D�=�<D n      EFE  ;  |}F o  y|�;�; "0 workingtasklist workingTaskList�=  �<  > G�:G l �9�8�7�9  �8  �7  �:  �o  �n   � H�6H r  ��IJI [  ��KLK o  ���5�5 0 tagindex tagIndexL m  ���4�4 J o      �3�3 0 tagindex tagIndex�6   � MNM Z  ��OP�2�1O l ��Q�0�/Q o  ���.�.  0 foundtagintask foundTagInTask�0  �/  P k  ��RR STS r  ��UVU I  ���-W�,�- 0 
removeitem 
removeItemW XYX o  ���+�+ 0 	taskindex 	taskIndexY Z�*Z o  ���)�) 0 curtasklist curTaskList�*  �,  V n      [\[ 4  ���(]
�( 
cobj] o  ���'�' 0 	projindex 	projIndex\ n ��^_^ o  ���&�& 0 projecttasks projectTasks_ o  ���%�% 0 	parseddoc 	parsedDocT `�$` r  ��aba m  ���#
�# boovfalsb o      �"�"  0 foundtagintask foundTagInTask�$  �2  �1  N cdc l ���!� ��!  �   �  d e�e r  ��fgf [  ��hih o  ���� 0 	taskindex 	taskIndexi m  ���� g o      �� 0 	taskindex 	taskIndex�   � j�j r  ��klk [  ��mnm o  ���� 0 	projindex 	projIndexn m  ���� l o      �� 0 	projindex 	projIndex�   � opo l ������  �  �  p qrq l ���st�  s _ Y Commit modified data to the document if the current search tag was found in the document   t �uu �   C o m m i t   m o d i f i e d   d a t a   t o   t h e   d o c u m e n t   i f   t h e   c u r r e n t   s e a r c h   t a g   w a s   f o u n d   i n   t h e   d o c u m e n tr v�v Z  �wx��w > ��yzy o  ���� "0 workingtasklist workingTaskListz J  ����  x k  �{{ |}| r  ��~~ l ������ b  ����� o  ���� 0 	searchtag 	searchTag� m  ���� ���  :�  �   l     ��
�	� n      ���  :  ��� n ����� o  ���� 0 projects  � o  ���� 0 	parseddoc 	parsedDoc�
  �	  } ��� l ����� r  ���� o  ���� "0 workingtasklist workingTaskList� l     ���� n      ���  :  � � n ����� o  ���� 0 projecttasks projectTasks� o  ���� 0 	parseddoc 	parsedDoc�  �  � % the contents of workingTaskList   � ��� > t h e   c o n t e n t s   o f   w o r k i n g T a s k L i s t� ��� l �� ���  �   ��  � ���� r  ��� J  ����  � o      ���� "0 workingtasklist workingTaskList��  �  �  �  �� 0 	searchtag 	searchTag � o   ] ^���� 0 taglist tagList��  ��   � ��� l     ��������  ��  ��  � ��� l     ������  � @ : We're done! Send the modified document back to TaskPaper.   � ��� t   W e ' r e   d o n e !   S e n d   t h e   m o d i f i e d   d o c u m e n t   b a c k   t o   T a s k P a p e r .� ��� l ������ r  ��� n ��� I  �������� 0 getdocument getDocument��  ��  � o  ���� 0 	parseddoc 	parsedDoc� o      ���� 0 docstr docStr��  ��  � ��� l .������ O .��� r  "-��� o  "%���� 0 docstr docStr� l     ������ n      ��� 1  (,��
�� 
TPrt� o  %(���� 0 tpdoc tpDoc��  ��  � m  ���                                                                                  TkPr   alis    X  Macintosh HD               ��YhH+   ;�TaskPaper.app                                                   %-�^�}        ����  	                Applications    �ڭ�      �^��     ;�  'Macintosh HD:Applications:TaskPaper.app     T a s k P a p e r . a p p    M a c i n t o s h   H D  Applications/TaskPaper.app  / ��  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � + % Helper functions -------------------   � ��� J   H e l p e r   f u n c t i o n s   - - - - - - - - - - - - - - - - - - -� ��� l     ��������  ��  ��  � ��� l     ������  � > 8 removeItem removes the item at index i from the list ls   � ��� p   r e m o v e I t e m   r e m o v e s   t h e   i t e m   a t   i n d e x   i   f r o m   t h e   l i s t   l s� ��� l     ������  � � � This funciton is straight out of Matt Neuberg's "AppleScript: the Difinitive Guide" (page 102). The credit goes to him for publishing it.   � ���   T h i s   f u n c i t o n   i s   s t r a i g h t   o u t   o f   M a t t   N e u b e r g ' s   " A p p l e S c r i p t :   t h e   D i f i n i t i v e   G u i d e "   ( p a g e   1 0 2 ) .   T h e   c r e d i t   g o e s   t o   h i m   f o r   p u b l i s h i n g   i t .� ��� i     ��� I      ������� 0 
removeitem 
removeItem� ��� o      ���� 0 i  � ���� o      ���� 0 ls  ��  ��  � Z     .����� =    ��� o     ���� 0 ls  � J    ����  � L    
�� J    	����  � ��� =   ��� o    ���� 0 i  � m    ���� � ���� L    �� n    ��� 1    ��
�� 
rest� o    ���� 0 ls  ��  � L    .�� b    -��� J    !�� ���� n    ��� 4    ���
�� 
cobj� m    ���� � o    ���� 0 ls  ��  � I   ! ,������� 0 
removeitem 
removeItem� ��� \   " %��� o   " #���� 0 i  � m   # $���� � ���� n   % (��� 1   & (��
�� 
rest� o   % &���� 0 ls  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � ~ x This is a variation of the above (created by myself) that takes a reference to a list item and removes it from the list   � ��� �   T h i s   i s   a   v a r i a t i o n   o f   t h e   a b o v e   ( c r e a t e d   b y   m y s e l f )   t h a t   t a k e s   a   r e f e r e n c e   t o   a   l i s t   i t e m   a n d   r e m o v e s   i t   f r o m   t h e   l i s t� ���� i    ��� I      ������� ,0 removereferenceditem removeReferencedItem� ��� o      ���� 0 rf  � ���� o      ���� 0 ls  ��  ��  � Z     1��� � =     o     ���� 0 ls   J    ����  � L    
 J    	����  �  =    n    	 4    ��

�� 
cobj
 m    ���� 	 o    ���� 0 ls   l   ���� n     1    ��
�� 
pcnt o    ���� 0 rf  ��  ��   �� L     n     1    ��
�� 
rest o    ���� 0 ls  ��    L     1 b     0 J     & �� n     $ 4   ! $��
�� 
cobj m   " #����  o     !���� 0 ls  ��   I   & /������ ,0 removereferenceditem removeReferencedItem  o   ' (���� 0 rf   �� n   ( + 1   ) +��
�� 
rest o   ( )���� 0 ls  ��  ��  ��       �� !"#��    �������� 0 
removeitem 
removeItem�� ,0 removereferenceditem removeReferencedItem
�� .aevtoappnull  �   � ****! �������$%���� 0 
removeitem 
removeItem�� ��&�� &  ������ 0 i  �� 0 ls  ��  $ ������ 0 i  �� 0 ls  % ������
�� 
rest
�� 
cobj�� 0 
removeitem 
removeItem�� /�jv  jvY #�k  
��,EY ��k/kv*�k��,l+ %" �������'(���� ,0 removereferenceditem removeReferencedItem�� ��)�� )  ������ 0 rf  �� 0 ls  ��  ' ������ 0 rf  �� 0 ls  ( ��������
�� 
cobj
�� 
pcnt
�� 
rest�� ,0 removereferenceditem removeReferencedItem�� 2�jv  jvY &��k/��,  
��,EY ��k/kv*���,l+ %# ��*����+,��
�� .aevtoappnull  �   � ***** k    .--  ..  B//  V00  d11  z22  33 �44 �����  ��  ��  + ���� 0 	searchtag 	searchTag, 1������ $����~�} +�| 0�{ J M�z c�y�x�w�v�u�t�s�r�q�p�o�n�m�l�k�j�i�h�g ��f�e(�d�c�b�a9�`��_�^�]
�� 
file
�� .earsffdralis        afdr
�� 
TEXT
�� .sysoloadscpt        file� 
0 munger  �~  �}  
�| 
btns
�{ .sysodlogaskr        TEXT�z 0 taglist tagList
�y 
docu
�x 
pcnt�w 0 tpdoc tpDoc�v "0 parsetpdocument parseTPDocument�u 0 	parseddoc 	parsedDoc�t "0 workingtasklist workingTaskList
�s 
kocl
�r 
cobj
�q .corecnte****       ****�p 0 	projindex 	projIndex�o 0 projecttasks projectTasks
�n 
leng�m 0 curtasklist curTaskList�l 0 	taskindex 	taskIndex�k 0 curtask curTask�j  0 foundtagintask foundTagInTask�i 0 tagindex tagIndex�h 0 tags  �g 0 curtag curTag�f ,0 removereferenceditem removeReferencedItem�e 0 task  �d 0 projects  
�c 
cha 
�b 
rvse
�a 
rest�` 0 
removeitem 
removeItem�_ 0 getdocument getDocument�^ 0 docstr docStr
�] 
TPrt��/ *�)j �&�%/j E�W X  ���kvl OhO��lvE�O� *a k/Ea ,E` UO�_ k+ E` OjvE` O��[a a l kh  kE` OghZ_ _ a ,a , _ a ,a _ /E` Y OkE` O#hZ_ _ a , _ a _ /E` Y OfE` OkE`  O �hZ_  _ a !,a , _ a !,a _  /E` "Y Oa #�%_ "a ,  jeE` O*_ "_ a !,l+ $_ a !,FO_ a %,a &_ a ',a _ /a (-a ),a *,a ),%�&a +%%_ a %,FO_ a ,_ 6GOPY hO_  kE`  [OY�OO_  %*_ _ l+ ,_ a ,a _ /FOfE` Y hO_ kE` [OY��O_ kE` [OY��O_ jv '�a -%_ a ',5FO_ _ a ,5FOjvE` Y h[OY�\O_ j+ .E` /O� _ /_ a 0,FUascr  ��ޭ