(this.webpackJsonpfrontend=this.webpackJsonpfrontend||[]).push([[0],{157:function(e,t,n){},158:function(e,t,n){},164:function(e,t,n){},184:function(e,t,n){},186:function(e,t,n){},204:function(e,t,n){},205:function(e,t,n){"use strict";n.r(t);var a=n(0),c=n.n(a),i=n(105),s=n.n(i),l=(n(157),n(27)),r=n(8),d=(n(158),n(3)),j=function(e){var t=e.page,n=t.charAt(0).toUpperCase()+t.slice(1);return Object(d.jsx)(l.b,{to:"/".concat(t),className:"headerlink-title",children:n})},o=function(){return Object(d.jsx)("div",{className:"header",children:Object(d.jsxs)("div",{className:"nav-container",children:[Object(d.jsx)(j,{page:"om"}),Object(d.jsx)(j,{page:"uppladdning"})]})})},b=(n(164),n(215)),p=n(216),u=n(24),h=n(210),x=n(211),O=n(10),m=Object(a.createContext)(!1);function g(e){var t=e.children,n=Object(a.useState)(!1),c=Object(O.a)(n,2),i=c[0],s=c[1],l=Object(a.useState)(null),r=Object(O.a)(l,2),j=r[0],o=r[1],b=Object(a.useState)(!1),p=Object(O.a)(b,2),u=p[0],h=p[1],x={setIsPlaying:s,getIsPlaying:i,setAudioRef:o,getIsLoading:u};return Object(a.useEffect)((function(){null!==j&&(i?(j.src="https://stream.radiodiabetes.eu/",j.oncanplay=function(e){h(!1)},h(!0),j.play()):(u?h(!1):j.pause(),j.src=""))}),[i,j]),Object(d.jsxs)(m.Provider,{value:x,children:[t," "]})}var f=function(){return Object(a.useContext)(m)},k=n(106),v=n.n(k);function y(){var e=f(),t=e.getIsPlaying,n=e.setIsPlaying,a=e.setAudioRef,c=e.getIsLoading,i=t?"pausa":"lyssna till";return Object(d.jsxs)("div",{className:"playbar",children:[Object(d.jsxs)(b.a,{columns:[2],gap:[1],children:[Object(d.jsx)(p.a,{style:{color:"lightgrey",textAlign:"center",paddingTop:"0.85em",height:"100%",width:"200px",fontSize:"70%"},weight:"semibold",children:c?"Radion laddar ...":"Klicka h\xe4r f\xf6r att ".concat(i," radion:")}),Object(d.jsx)(u.Button,{style:{width:"2em",marginLeft:"3.5em",height:"2em"},icon:t?c?Object(d.jsx)(v.a,{type:"Oval",color:"white",height:15,width:15}):h.a:x.a,onClick:function(){c||n(!t)}}),Object(d.jsx)("audio",{ref:function(e){return a(e)}})]})," "]})}n(184);var N=n.p+"static/media/output.2909dd92.gif";function S(){return Object(d.jsxs)("div",{className:"infotext",children:[Object(d.jsxs)("h2",{children:["V\xe4lkommen till ",Object(d.jsx)("em",{children:"Radio Diabetes"}),"!"]}),Object(d.jsx)("img",{src:N,alt:"",srcset:""}),Object(d.jsxs)("p",{children:[Object(d.jsx)("em",{children:"Radio Diabetes"})," \xe4r mitt examensprojekt inom kandidatutbildningen"," ",Object(d.jsx)("em",{children:"Elektroakustisk komposition"})," p\xe5 ",Object(d.jsx)("em",{children:"Kungliga Musikh\xf6gskolan"}),". Vill du l\xe4sa den examenstext tillh\xf6rande projektet finns den att ladda ned h\xe4r. All kod f\xf6r projektet finns tillg\xe4nglig"," ",Object(d.jsx)("a",{target:"_blank",href:"http://repo.radiodiabetes.eu",children:"h\xe4r"}),"!"]}),Object(d.jsxs)("p",{children:["Skicka mejl ",Object(d.jsx)("a",{href:"mailto:info@radiodiabetes.eu",children:"h\xe4r"}),"."]})]})}var P=n(52),w=n(217),I=n(212),A=n(214),C=(n(186),n(111)),D=n.n(C),E=n(112),L=n(113),T=n(43),R=n(115),_=n(114),M=(n(204),function(e){Object(R.a)(n,e);var t=Object(_.a)(n);function n(e){var a;return Object(E.a)(this,n),(a=t.call(this,e)).state={open:!1},a.togglePanel=a.togglePanel.bind(Object(T.a)(a)),a}return Object(L.a)(n,[{key:"togglePanel",value:function(e){this.setState({open:!this.state.open})}},{key:"render",value:function(){var e=this;return Object(d.jsxs)("div",{className:"instruktioner",children:[Object(d.jsxs)("div",{onClick:function(t){return e.togglePanel(t)},className:"collapsible",children:[Object(d.jsx)("div",{className:"instructions-title",children:this.props.title}),Object(d.jsx)("div",{className:"expand-btn",children:Object(d.jsx)("svg",{className:this.state.open?"expand-arrow--expanded":null,viewBox:"0 0 100 100",children:Object(d.jsx)("path",{d:"M5 15 L50 85 L95 15"})})})]}),this.state.open?Object(d.jsx)("div",{className:"content",children:this.props.children}):null]})}}]),n}(c.a.Component)),V=n.p+"static/media/nr_1.cc494ec8.png",F=n.p+"static/media/nr_2.96970491.png",K=n.p+"static/media/nr_3.9ff247e8.png",B=n.p+"static/media/nr_4.2781d3c5.png",H=n.p+"static/media/nr_5.8a595187.png";function J(){var e=Object(a.useState)(""),t=Object(O.a)(e,2),n=t[0],c=t[1],i=Object(a.useState)(null),s=Object(O.a)(i,2),l=s[0],j=s[1],o=Object(a.useState)(null),b=Object(O.a)(o,2),h=b[0],x=b[1],m=Object(a.useState)(!1),g=Object(O.a)(m,2),k=g[0],v=g[1],y=f(),N=y.setIsPlaying,S=y.getIsPlaying,C=y.setAudioRef,E=Object(u.useToast)().push,L=Object(a.useState)(!0),T=Object(O.a)(L,2),R=T[0],_=T[1],J=Object(a.useState)(!1),z=Object(O.a)(J,2),G=z[0],U=z[1];return Object(a.useEffect)((function(){if(h)return D.a.post("/api/uppladdning",h).then((function(e){e.data.uploadSuccess?(v(!0),E({title:"Tack!",description:"Ditt bidrag har mottagits!",status:"success"}),P.isMobile||S||N(!0)):E({title:"Hoppsan!",description:"N\xe5got har blivit fel. V\xe4nligen f\xf6rs\xf6k igen!",status:"error"})})).catch((function(){E({title:"Hoppsan!",description:"N\xe5got har blivit fel. V\xe4nligen f\xf6rs\xf6k igen!",status:"error"})})),!1}),[h,S,E,N,C]),k&&!P.isMobile?Object(d.jsx)(r.a,{to:"/"}):Object(d.jsxs)("div",{children:[Object(d.jsx)("div",{className:"form",children:Object(d.jsxs)("form",{style:{justifyItems:"center"},onSubmit:function(e){e.preventDefault();var t=new FormData;t.append("file",l),t.append("message",n),x(t)},id:"uploadform",children:[Object(d.jsxs)(w.a,{align:"center",children:[Object(d.jsx)(I.a,{id:"checkbox",onClick:function(e){_(!e.currentTarget.checked)},style:{display:"block"}}),Object(d.jsx)(A.a,{flex:1,paddingLeft:3,children:Object(d.jsx)(p.a,{children:Object(d.jsx)("label",{htmlFor:"checkbox",children:"Genom att kryssa i denna ruta godk\xe4nner jag anv\xe4ndandet av den uppladdade datan i detta projekt."})})})]}),Object(d.jsx)(w.a,{align:"left",children:Object(d.jsx)(p.a,{children:Object(d.jsx)("label",{htmlFor:"meddelande",style:R?{textAlign:"left",color:"gray"}:{textAlign:"left"},children:"L\xe4mna ett meddelande (frivilligt):"})})}),Object(d.jsx)(w.a,{align:"center",children:Object(d.jsx)("textarea",{disabled:R,name:"text",id:"",cols:"30",rows:"4",value:n,onChange:function(e){c(e.currentTarget.value)}})}),Object(d.jsx)("input",{type:"file",onChange:function(e){var t=e.target.files[0];t&&("xls"===t.name.split(".").pop()||"xlsx"===t.name.split(".").pop())?(j(t),U(!0)):U(!1)},accept:".xls, .xlsx, .csv",id:"upload",disabled:R}),Object(d.jsx)(w.a,{align:"center",children:Object(d.jsx)("button",{disabled:G?R:"disabled",type:"submit",children:"Dela"})})]})}),Object(d.jsx)(M,{title:"Instruktioner (klicka h\xe4r!)",children:Object(d.jsxs)("div",{className:"instructions",children:[" ",Object(d.jsx)("p",{children:"F\xf6lj instruktionerna nedan f\xf6r att delta i radiostr\xf6mmen."}),Object(d.jsxs)("p",{children:["1. Surfa in p\xe5"," ",Object(d.jsx)("a",{href:"https://diasend.com/",children:"https://diasend.com/"})," och logga in:",Object(d.jsx)("img",{src:V,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:["2. Klicka p\xe5 f\xe4ltet ",Object(d.jsx)("em",{children:'"Dela data"'}),":",Object(d.jsx)("img",{src:F,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:['3. Klicka sedan p\xe5 "',Object(d.jsx)("em",{children:"Exportera data"}),'":',Object(d.jsx)("img",{src:K,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:['4. Skriv in koden i f\xe4ltet "',Object(d.jsx)("em",{children:"Ange koden nedan"}),'", och klicka sedan p\xe5 "',Object(d.jsx)("em",{children:"Exportera till Excel"}),'". En ".xls"-fil med dina v\xe4rden kommer nu att sparas till din dator. Du hittar filen i din Nedladdat-mapp.',Object(d.jsx)("img",{src:B,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:['5. Till sist laddar du upp ".xls"-filen genom att f\xf6rst klicka i rutan d\xe4r du godk\xe4nner att filen anv\xe4nds, och sedan klickar p\xe5 knappen "',Object(d.jsx)("em",{children:"V\xe4lj fil"}),'". Du f\xe5r g\xe4rna l\xe4mna ett meddelande om du vill, detta kommer inte att publiceras och \xe4r anonymt.',Object(d.jsx)("img",{src:H,alt:"",srcset:""})]})]})})]})}var z=function(){return Object(d.jsx)("div",{className:"App",children:Object(d.jsxs)(l.a,{children:[Object(d.jsx)(o,{}),Object(d.jsx)(y,{}),Object(d.jsx)(r.b,{exact:!0,path:"/",component:S}),Object(d.jsx)(r.b,{exact:!0,path:"/om",component:S}),Object(d.jsx)(r.b,{exact:!0,path:"/uppladdning",component:J})]})})},G=n(37),U=n(213);s.a.render(Object(d.jsx)(c.a.StrictMode,{children:Object(d.jsx)(G.a,{theme:U.a,scheme:"light",children:Object(d.jsx)(u.ToastProvider,{children:Object(d.jsx)(g,{children:Object(d.jsx)(z,{})})})})}),document.getElementById("root"))}},[[205,1,2]]]);
//# sourceMappingURL=main.1d7a4599.chunk.js.map