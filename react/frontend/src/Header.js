import "./Header.css";

import { Grid } from "@sanity/ui";
import { Link } from "react-router-dom";

const HeaderLink = ({ page, link }) => {
  const title = page.charAt(0).toUpperCase() + page.slice(1);
  return (
    <Link to={link ? link : `/${page}`} className="headerlink-title">
      {title}
    </Link>
  );
};

const Header = () => {
  return (
    <div className="header">
      {/*      <Grid
        columns={[3]}
        gap={[0]}
        style={{
          width: "50%",
          maxWidth: "420px",
          minWidth: "310px",
          textAlign: "center",
        }}
      >*/}
      <div className="nav-container">
        <HeaderLink page="hem" link="/"></HeaderLink>
        {/*<HeaderLink page="uppladdning"></HeaderLink>*/}
        <HeaderLink page="uppladdning"></HeaderLink>
        <HeaderLink page="om"></HeaderLink>
        <HeaderLink page="kontakt"></HeaderLink>
        {/*<HeaderLink page="kontakt"></HeaderLink>*/}
      </div>
    </div>
  );
};

export default Header;
