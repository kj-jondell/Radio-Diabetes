(this.webpackJsonpfrontend=this.webpackJsonpfrontend||[]).push([[0],{157:function(e,t,n){},158:function(e,t,n){},165:function(e,t,n){},185:function(e,t,n){},186:function(e,t,n){},204:function(e,t,n){},205:function(e,t,n){"use strict";n.r(t);var a=n(0),c=n.n(a),i=n(105),s=n.n(i),l=(n(157),n(27)),r=n(8),d=(n(158),n(3)),j=function(e){var t=e.page,n=t.charAt(0).toUpperCase()+t.slice(1);return Object(d.jsx)(l.b,{to:"/".concat(t),className:"headerlink-title",children:n})},o=function(){return Object(d.jsx)("div",{className:"header",children:Object(d.jsxs)("div",{className:"nav-container",children:[Object(d.jsx)(j,{page:"om"}),Object(d.jsx)(j,{page:"uppladdning"})]})})},b=n(41),p=(n(165),n(217)),h=n(216),u=n(24),x=n(210),O=n(211),g=n(10),m=Object(a.createContext)(!1);function f(e){var t=e.children,n=Object(a.useState)(!1),c=Object(g.a)(n,2),i=c[0],s=c[1],l=Object(a.useState)(null),r=Object(g.a)(l,2),j=r[0],o=r[1],b=Object(a.useState)(!1),p=Object(g.a)(b,2),h=p[0],u=p[1],x={setIsPlaying:s,getIsPlaying:i,setAudioRef:o,getIsLoading:h};return Object(a.useEffect)((function(){null!==j&&(i?(j.src="https://stream.radiodiabetes.eu/",j.load(),j.oncanplay=function(e){u(!1)},u(!0),j.play()):(h?u(!1):j.pause(),j.src=""))}),[i,j]),Object(d.jsxs)(m.Provider,{value:x,children:[t," "]})}var k=function(){return Object(a.useContext)(m)},v=n(106),y=n.n(v);function S(){var e=k(),t=e.getIsPlaying,n=e.setIsPlaying,a=e.setAudioRef,c=e.getIsLoading,i=t?"pausa":"lyssna till";return Object(d.jsxs)("div",{className:"playbar",children:[Object(d.jsxs)(p.a,{columns:[2],gap:[1],children:[Object(d.jsx)(h.a,{style:{color:"lightgrey",textAlign:"center",paddingTop:"0.85em",height:"100%",width:"200px",fontSize:"70%"},weight:"semibold",children:c?"Radion laddar ...":"Klicka h\xe4r f\xf6r att ".concat(i," radion:")}),Object(d.jsx)(u.Button,{style:{width:"2em",marginLeft:"3.5em",height:"2em"},icon:t?c?Object(d.jsx)(y.a,{type:"Oval",color:"white",height:15,width:15}):x.a:O.a,onClick:function(){c||n(!t)}}),Object(d.jsx)("audio",{ref:function(e){return a(e)}})]})," "]})}n(185);function N(){return Object(d.jsxs)("div",{className:"infotext",children:[Object(d.jsxs)("h2",{children:["V\xe4lkommen till ",Object(d.jsx)("em",{children:"Radio Diabetes"}),"!"]}),Object(d.jsxs)("p",{children:[Object(d.jsx)("em",{children:"Radio Diabetes"})," \xe4r mitt examensprojekt inom kandidatutbildningen"," ",Object(d.jsx)("em",{children:"Elektroakustisk komposition"})," p\xe5 ",Object(d.jsx)("em",{children:"Kungliga Musikh\xf6gskolan"}),"."]}),Object(d.jsxs)("p",{children:[Object(d.jsx)("em",{children:"Radio Diabetes"})," \xe4r Karl Johannes Jondells examensprojekt i kandidatutbildningen elektroakustisk komposition p\xe5 Kungliga Musikh\xf6gskolan. Vill du l\xe4sa den examenstext tillh\xf6rande projektet finns den att ladda ned h\xe4r. All kod f\xf6r projektet finns tillg\xe4nglig"," ",Object(d.jsx)("a",{target:"_blank",href:"http://repo.radiodiabetes.eu",children:"h\xe4r"}),"!"]}),Object(d.jsxs)("p",{children:["Skicka mejl ",Object(d.jsx)("a",{href:"mailto:info@radiodiabetes.eu",children:"h\xe4r"}),"."]})]})}var P=n(215),w=n(213),I=n(214),A=(n(186),n(111)),C=n.n(A),D=n(112),E=n(113),L=n(44),R=n(115),T=n(114),K=(n(204),function(e){Object(R.a)(n,e);var t=Object(T.a)(n);function n(e){var a;return Object(D.a)(this,n),(a=t.call(this,e)).state={open:!1},a.togglePanel=a.togglePanel.bind(Object(L.a)(a)),a}return Object(E.a)(n,[{key:"togglePanel",value:function(e){this.setState({open:!this.state.open})}},{key:"render",value:function(){var e=this;return Object(d.jsxs)("div",{className:"instruktioner",children:[Object(d.jsxs)("div",{onClick:function(t){return e.togglePanel(t)},className:"collapsible",children:[Object(d.jsx)("div",{className:"instructions-title",children:this.props.title}),Object(d.jsx)("div",{className:"expand-btn",children:Object(d.jsx)("svg",{className:this.state.open?"expand-arrow--expanded":null,viewBox:"0 0 100 100",children:Object(d.jsx)("path",{d:"M5 15 L50 85 L95 15"})})})]}),this.state.open?Object(d.jsx)("div",{className:"content",children:this.props.children}):null]})}}]),n}(c.a.Component)),M=n.p+"static/media/nr_1.cc494ec8.png",_=n.p+"static/media/nr_2.96970491.png",V=n.p+"static/media/nr_3.9ff247e8.png",F=n.p+"static/media/nr_4.2781d3c5.png",J=n.p+"static/media/nr_5.88839ca0.png";function B(){var e=Object(a.useState)(""),t=Object(g.a)(e,2),n=t[0],c=t[1],i=Object(a.useState)(null),s=Object(g.a)(i,2),l=s[0],j=s[1],o=Object(a.useState)(null),p=Object(g.a)(o,2),x=p[0],O=p[1],m=Object(a.useState)(!1),f=Object(g.a)(m,2),v=f[0],y=f[1],S=k(),N=S.setIsPlaying,A=S.getIsPlaying,D=S.setAudioRef,E=Object(u.useToast)().push,L=Object(a.useState)(!0),R=Object(g.a)(L,2),T=R[0],B=R[1],H=Object(a.useState)(!1),z=Object(g.a)(H,2),G=z[0],U=z[1];return Object(a.useEffect)((function(){if(x)return C.a.post("/api/uppladdning",x).then((function(e){e.data.uploadSuccess?(y(!0),E({title:"Tack!",description:"Ditt bidrag har mottagits!",status:"success"}),b.isMobile||A||N(!0)):E({title:"Hoppsan!",description:"N\xe5got har blivit fel. V\xe4nligen f\xf6rs\xf6k igen!",status:"error"})})).catch((function(){E({title:"Hoppsan!",description:"N\xe5got har blivit fel. V\xe4nligen f\xf6rs\xf6k igen!",status:"error"})})),!1}),[x,A,E,N,D]),v&&!b.isMobile?Object(d.jsx)(r.a,{to:"/"}):Object(d.jsxs)("div",{children:[Object(d.jsx)("div",{className:"form",children:Object(d.jsxs)("form",{style:{justifyItems:"center"},onSubmit:function(e){e.preventDefault();var t=new FormData;t.append("file",l),t.append("message",n),O(t)},id:"uploadform",children:[Object(d.jsxs)(P.a,{align:"center",children:[Object(d.jsx)(w.a,{id:"checkbox",onClick:function(e){B(!e.currentTarget.checked)},style:{display:"block"}}),Object(d.jsx)(I.a,{flex:1,paddingLeft:3,children:Object(d.jsx)(h.a,{children:Object(d.jsx)("label",{htmlFor:"checkbox",children:"Genom att klicka i denna knapp godk\xe4nner jag anv\xe4ndandet av den uppladdade datan i detta projekt."})})})]}),Object(d.jsx)(P.a,{align:"left",children:Object(d.jsx)(h.a,{children:Object(d.jsx)("label",{htmlFor:"meddelande",style:T?{textAlign:"left",color:"gray"}:{textAlign:"left"},children:"L\xe4mna ett meddelande (frivilligt):"})})}),Object(d.jsx)(P.a,{align:"center",children:Object(d.jsx)("textarea",{disabled:T,name:"text",id:"",cols:"30",rows:"4",value:n,onChange:function(e){c(e.currentTarget.value)}})}),Object(d.jsx)("input",{type:"file",onChange:function(e){var t=e.target.files[0];t&&("xls"===t.name.split(".").pop()||"xlsx"===t.name.split(".").pop())?(j(t),U(!0)):U(!1)},accept:".xls, .xlsx, .csv",id:"upload",disabled:T}),Object(d.jsx)(P.a,{align:"center",children:Object(d.jsx)("button",{disabled:G?T:"disabled",type:"submit",children:"Dela"})})]})}),Object(d.jsx)(K,{title:"Instruktioner (klicka h\xe4r!)",children:Object(d.jsxs)("div",{className:"instructions",children:[" ",Object(d.jsx)("p",{children:"F\xf6lj instruktionerna nedan f\xf6r att delta i radiostr\xf6mmen."}),Object(d.jsxs)("p",{children:["1. Surfa in p\xe5"," ",Object(d.jsx)("a",{href:"https://diasend.com/",children:"https://diasend.com/"})," och logga in:",Object(d.jsx)("img",{src:M,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:["2. Klicka p\xe5 f\xe4ltet ",Object(d.jsx)("em",{children:'"Dela data"'}),":",Object(d.jsx)("img",{src:_,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:['3. Klicka sedan p\xe5 "',Object(d.jsx)("em",{children:"Exportera data"}),'":',Object(d.jsx)("img",{src:V,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:['4. Skriv in koden i f\xe4ltet "Ange koden nedan", och klicka sedan p\xe5 "Exportera till Excel":',Object(d.jsx)("img",{src:F,alt:"",srcset:""})]}),Object(d.jsxs)("p",{children:['5. Till sist laddar du upp ".xls" filen genom att f\xf6rst klicka i rutan d\xe4r du godk\xe4nner att filen anv\xe4nds, och sedan klicka p\xe5 knappen "',Object(d.jsx)("em",{children:"V\xe4lj fil"}),'":',Object(d.jsx)("img",{src:J,alt:"",srcset:""})]})]})})]})}var H=function(){return Object(d.jsx)("div",{className:"App",children:Object(d.jsxs)(l.a,{children:[Object(d.jsx)(o,{}),Object(d.jsx)(r.b,{path:"/:page",component:S}),Object(d.jsx)(r.b,{exact:!0,path:"/",component:S}),Object(d.jsx)(r.b,{exact:!0,path:"/",component:N}),Object(d.jsx)(r.b,{exact:!0,path:"/om",component:N}),Object(d.jsx)(r.b,{exact:!0,path:"/uppladdning",component:B})]})})},z=n(37),G=n(212);s.a.render(Object(d.jsx)(c.a.StrictMode,{children:Object(d.jsx)(z.a,{theme:G.a,scheme:"light",children:Object(d.jsx)(u.ToastProvider,{children:Object(d.jsx)(f,{children:Object(d.jsx)(H,{})})})})}),document.getElementById("root"))}},[[205,1,2]]]);
//# sourceMappingURL=main.91ef4f96.chunk.js.map