import "./Header.css";

import {Link} from "react-router-dom";

const HeaderLink = ({page}) => {
  const title = page.toUpperCase(); //page.charAt(0).toUpperCase() + page.slice(1);
  return (
    <Link to={`/${page}`} className="headerlink-title">
      {title}
    </Link>
  );
};

const Header = () => {
  return (
    <div className="header">
      <HeaderLink page="om"></HeaderLink>
      {/*<HeaderLink page="uppladdning"></HeaderLink>*/}
      <HeaderLink page="uppladdning"></HeaderLink>
      <HeaderLink page="kontakt"></HeaderLink>
    </div>
  );
};

export default Header;
